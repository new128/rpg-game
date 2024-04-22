extends KinematicBody

var target_position = Vector3.ZERO
var rotation_threshold = 0.1
var rotation_speed = 5
# Загрузка класса
var Person = preload("res://person.gd")
var Item = preload("res://item.gd")
var Inventory = preload("res://inventory.gd")
var Skill = preload("res://ability.gd")
var person = Person.new("paladin", "play_pers","left",
{"max_hp" : 1000, "hp": 1000, "max_mana": 200, "mana": 200, "regen_hp": 5, "regen_mana" : 1, "armor":10, "magic_damage_resist" : 30, "damage": 80, "attack_speed" : 2, "attack_radius" : 2.5, "speed" : 6,"max_skills" : 3, "lvl" : 1, "xp" : 0, "time" : 0},
null, Inventory.new({"head" : null, "shoulders" : null, "left_hand" : null, "right_hand" : null, "body" : null, "legs" : null}, [0,0,0]), 500)
var back_object = null
var is_move = false
var last_attack = null
var giv_money = 300
var is_die = false
var effects_p = []
var effects_time = []
var el_t = 0

func _ready():
	person.team = "left"

func _process(delta):
	var kin_bod = get_node("/root/Spatial/Control/Time")
	el_t = int(kin_bod.elapsed_time)
	
	# Обработка движения персонажа
	move_and_slide(Vector3.ZERO)
	
	
	for key in person.inventory.weapons:
		if person.inventory.weapons[key]:
			var new_texture_path = "res://item_img/" + person.inventory.weapons[key].item_stats["name"] + ".png"
			get_node("/root/Spatial/Control/" + key + "/TextureRect").texture = load(new_texture_path)
		else:get_node("/root/Spatial/Control/" + key + "/TextureRect").texture = null

	if person.inventory.consumables.size() > 0:
		for i in person.inventory.consumables.size():
			if person.inventory.consumables[i]:
				var new_texture_path = "res://item_img/" + person.inventory.consumables[i].item_stats["name"] + ".png"
				get_node("/root/Spatial/Control/consumable" + str(i+1) + "/TextureRect").texture = load(new_texture_path)
			else:get_node("/root/Spatial/Control/consumable" + str(i+1) + "/TextureRect").texture = null
	
	person.count_stat()
	
	OS.set_window_fullscreen(true)
	
	person.person_stats["time"] += 1
	
	if person.attack_bool:
		if not person.attack(self, back_object):
			is_move = false
	
	var cgp = global_transform.origin
	var cam = get_node("/root/Spatial/Play_camera")
	var pos = cam.position
	var x_p = (pos.x + 9.5 - cgp.x)/18.91
	var y_p = (33.62 - (pos.z + 16.81 - cgp.z))/33.62
	
	$HUD.anchor_left = y_p-0.05
	$HUD.anchor_top = x_p-0.1
	
	$HUD/hp.max_value = person.person_stats["max_hp"]
	$HUD/hp.value = person.person_stats["hp"]
	$HUD/mana.max_value = person.person_stats["max_mana"]
	$HUD/mana.value = person.person_stats["mana"]
	
	var direction = (target_position - translation).normalized()
	direction.y = 0
	
	if direction.length() > rotation_threshold:
		var angle = atan2(direction.x, direction.z)
		rotation_degrees.y = angle * 180 / PI
	
	effects()
	is_die = person.is_die()
	person.is_valid_stats()

	# Перемещение к целевой позиции
	if is_move:
		if target_position != Vector3.ZERO:
			
			move_and_slide(direction * person.person_stats["speed"])
			
			

func _input(event):
	# Обработка ввода от игрока
	var control_node = get_node("/root/Spatial/Control")
	control_node.connect("button_Z_pressed", self, "_on_button_Z_pressed")
	if event is InputEventKey and event.pressed and Input.is_action_pressed("Z"):
		_on_button_Z_pressed()
	control_node.connect("button_X_pressed", self, "_on_button_X_pressed")
	if event is InputEventKey and event.pressed and Input.is_action_pressed("X"):
		_on_button_X_pressed()
	control_node.connect("button_C_pressed", self, "_on_button_C_pressed")
	if event is InputEventKey and event.pressed and Input.is_action_pressed("C"):
		_on_button_C_pressed()
		
	if event is InputEventKey and event.pressed and Input.is_action_pressed("Q"):
		_on_button_Q_pressed()
		
	control_node.connect("button_buy_falakaxa_pressed", self, "_on_button_buy_falakaxa_pressed")
	control_node.connect("button_buy_pigeon_pressed", self, "_on_button_buy_pigeon_pressed")
	
	
	
	if event is InputEventMouseButton and event.pressed and Input.is_action_pressed("right_click"):
		# Получение позиции, на которую нажал игрок
		var mouse_position = event.position
		var clicked_point = get_viewport().get_camera().project_ray_origin(mouse_position)
		var ray_end = get_viewport().get_camera().project_ray_normal(mouse_position) * 1000 + clicked_point
		
		var space_state = get_world().direct_space_state
		var result = space_state.intersect_ray(clicked_point, ray_end)
		if result.has('collider'):
			var object = result.collider
			print(object.name)
			target_position = result.position
			if object.person != null:
				if object.person.team != person.team:
					back_object = object
					is_move = false
					print("Yes")
					if person.attack(self ,object):

					# Найти ближайшую точку на obj1 к obj2
						target_position = object.global_transform.origin
						is_move = true
				
					return
		#print(result)
		if result:
			target_position = result.position
			person.attack_bool = false
			is_move = true
			#print(target_position)
		
	
func effects():
	person.effect()
	for it in effects_p:
		if effects_time[effects_p.find(it.skill)]+10 <= el_t:
			person.person_stats["regen_hp"] -= it.skill["regen_hp"]
			person.person_stats["regen_mana"] -= it.skill["regen_mana"]
			effects_p.erase(it)
			effects_time.erase(it)
		
	
func _on_button_Z_pressed():
	if person.inventory.consumables[0]:
		if String(person.inventory.consumables[0].skill.skill["time"]) != "instantly":
			effects_p.append(person.inventory.consumables[0].skill)
			effects_time.append(el_t)
		person.inventory._use_ability(0, person)

func _on_button_X_pressed():
	if person.inventory.consumables[1]:
		if String(person.inventory.consumables[1].skill.skill["time"]) != "instantly":
			effects_p.append(person.inventory.consumables[1].skill)
			effects_time.append(el_t)
		person.inventory._use_ability(1, person)

func _on_button_C_pressed():
	if person.inventory.consumables[2]:
		if String(person.inventory.consumables[2].skill.skill["time"]) != "instantly":
			effects_p.append(person.inventory.consumables[2].skill)
			effects_time.append(el_t)
		person.inventory._use_ability(2, person)

func _on_button_Q_pressed():
	if person.money >= 120:
		person.inventory._add_ability("falakaxa")
		person.money -= 120
	else:
		print("NO MONEY")

func _on_button_buy_falakaxa_pressed():
	if person.money >= 120:
		person.inventory._add_ability("falakaxa")
		person.money -= 120
	else:
		print("NO MONEY")

func _on_button_buy_pigeon_pressed():
	if person.money >= 90:
		person.inventory._add_ability("pigeon")
		person.money -= 90
	else:
		print("NO MONEY")
