extends KinematicBody

var target_position = Vector3.ZERO
var speed = 10
var rotation_threshold = 0.1
var rotation_speed = 5
# Загрузка класса
var Person = preload("res://person.gd")
var Item = preload("res://item.gd") 
var person = Person.new("paladin",null)
var back_object = null
var is_move = false
var type = "play_pers"
var pers_type = "play_pers"

var last_attack = null

var giv_money = 300

var die = false

var effects_p = []
var effects_time = []
var el_t = null

func _ready():
	
	
	person.team = "left"

func _process(delta):
	var kin_bod = get_node("/root/Spatial/Control/Time")
	el_t = int(kin_bod.elapsed_time)
	
	# Обработка движения персонажа
	move_and_slide(Vector3.ZERO)
	
	
	
	
	if person.inventary.body:
		var new_texture_path = "res://item_img/" + person.inventary.body.name + ".png"
		get_node("/root/Spatial/Control/Body/TextureRect").texture = load(new_texture_path)
	else:get_node("/root/Spatial/Control/Body/TextureRect").texture = null
	if person.inventary.weapon_r:
		var new_texture_path = "res://item_img/" + person.inventary.weapon_r.name + ".png"
		get_node("/root/Spatial/Control/Weapon_r/TextureRect").texture = load(new_texture_path)
	else:get_node("/root/Spatial/Control/Weapon_r/TextureRect").texture = null
	if person.inventary.legs:
		var new_texture_path = "res://item_img/" + person.inventary.legs.name + ".png"
		get_node("/root/Spatial/Control/Legs/TextureRect").texture = load(new_texture_path)
	else:get_node("/root/Spatial/Control/Legs/TextureRect").texture = null
		
	if person.inventary.weapon_l:
		var new_texture_path = "res://item_img/" + person.inventary.weapon_l.name + ".png"
		get_node("/root/Spatial/Control/Weapon_l/TextureRect").texture = load(new_texture_path)
	else:get_node("/root/Spatial/Control/Weapon_l/TextureRect").texture = null
		
	if person.inventary.head:
		var new_texture_path = "res://item_img/" + person.inventary.head.name + ".png"
		get_node("/root/Spatial/Control/Head/TextureRect").texture = load(new_texture_path)
	else:get_node("/root/Spatial/Control/Head/TextureRect").texture = null
		
	if person.inventary.shoulders:
		var new_texture_path = "res://item_img/" + person.inventary.shoulders.name + ".png"
		get_node("/root/Spatial/Control/Plechi/TextureRect").texture = load(new_texture_path)
	else:get_node("/root/Spatial/Control/Plechi/TextureRect").texture = null
	if person.inventary.consumables.size() > 0:
		if person.inventary.consumables[0]:
			var new_texture_path = "res://item_img/" + person.inventary.consumables[0].name + ".png"
			get_node("/root/Spatial/Control/consumable1/TextureRect").texture = load(new_texture_path)
		else:get_node("/root/Spatial/Control/consumable1/TextureRect").texture = null
		if person.inventary.consumables[1]:
			var new_texture_path = "res://item_img/" + person.inventary.consumables[1].name + ".png"
			get_node("/root/Spatial/Control/consumable2/TextureRect").texture = load(new_texture_path)
		else:get_node("/root/Spatial/Control/consumable2/TextureRect").texture = null
		if person.inventary.consumables[2]:
			var new_texture_path = "res://item_img/" + person.inventary.consumables[2].name + ".png"
			get_node("/root/Spatial/Control/consumable3/TextureRect").texture = load(new_texture_path)
		else:get_node("/root/Spatial/Control/consumable3/TextureRect").texture = null
	
	
	
	
	
	
	
	
	
	person.count_stat()
	
	
	
	
	
	OS.set_window_fullscreen(true)
	
	
	person.time+=1
	
	
	if person.attack_bool:
		if not person.attack(self, back_object):
			is_move = false
	
	
	var cgp = global_transform.origin
	var screen_size = OS.get_screen_size()
	var cam = get_node("/root/Spatial/Play_camera")
	var pos = cam.position

	var x_pos = pos.x + 9.5 - cgp.x
	var y_pos = 33.62 - (pos.z + 16.81 - cgp.z)
	
	var x_p = 1*x_pos/18.91
	var y_p = 1*y_pos/33.62
	
	#print(x_p)
	#print(y_p)
	
	$HUD.anchor_left = y_p-0.05
	$HUD.anchor_top = x_p-0.1
	
	
	
	
	$HUD/hp.max_value = person.max_hp
	$HUD/hp.value = person.hp
	$HUD/mana.max_value = person.max_mana
	$HUD/mana.value = person.mana
	
	
	var direction = (target_position - translation).normalized()
	direction.y = 0
	
	if direction.length() > rotation_threshold:
		var angle = atan2(direction.x, direction.z)
		rotation_degrees.y = angle * 180 / PI
	
	
	effects()
	die()

	# Перемещение к целевой позиции
	if is_move:
		if target_position != Vector3.ZERO:
			
			move_and_slide(direction * person.speed)
			
			

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
	person.hp += (person.regen_hp / 60.0)
	person.mana += (person.regen_mana / 60.0)
	for it in effects_p:
		if it.name == "flask" and effects_time[effects_p.find(it)]+10 <= el_t:
			person.regen_hp -= 30
			effects_p.erase(it)
			effects_time.erase(it)
			
			

	
func die():
	if person.hp <= 0:
		person.hp = 0
		print("die")
		die = true
	if person.hp == person.max_hp:
		person.hp = person.max_hp
	if person.mana <= 0:
		person.mana = 0
		print("Dont mama")
	if person.hp >= person.max_hp:
		person.hp = person.max_hp
	if person.mana >= person.max_mana:
		person.mana = person.max_mana
		

func _on_button_Z_pressed():
	if person.inventary.consumables[3]:
		if person.inventary.consumables[0].scil.name == "flask":
			person.regen_hp += 30
		if person.inventary.consumables[0].scil.name == "clarety":
			person.regen_mana += 20
		if person.inventary.consumables[0].scil.name == "fairik":
			person.hp += 100
		
		if String(person.inventary.consumables[0].scil.scil["time"]) != "instantly":
			effects_p.append(person.inventary.consumables[0].scil)
			effects_time.append(el_t)
	
	
	
	person.inventary.consumables[0] = null
func _on_button_X_pressed():
	if person.inventary.consumables[1]:
		if person.inventary.consumables[1].scil.name == "flask":
			person.regen_hp += 30
		if person.inventary.consumables[1].scil.name == "clarety":
			person.regen_mana += 20
		if person.inventary.consumables[1].scil.name == "fairik":
			person.hp += 100
		
		if String(person.inventary.consumables[1].scil.scil["time"]) != "instantly":
			effects_p.append(person.inventary.consumables[1].scil)
			effects_time.append(el_t)
		
		person.inventary.consumables[1] = null
func _on_button_C_pressed():
	if person.inventary.consumables[2]:
		if person.inventary.consumables[2].scil.name == "flask":
			person.regen_hp += 30
		if person.inventary.consumables[2].scil.name == "clarety":
			person.regen_mana += 20
		if person.inventary.consumables[2].scil.name == "fairik":
			person.hp += 100
		
		if String(person.inventary.consumables[2].scil.scil["time"]) != "instantly":
			effects_p.append(person.inventary.consumables[2].scil)
			effects_time.append(el_t)
		person.inventary.consumables[2] = null
	
	
	
func _on_button_Q_pressed():
	if person.money >= 120:
		if person.inventary.consumables[0] == null:
			person.money -= 120
			person.inventary.consumables[0] = Item.new("falakaxa")
		elif person.inventary.consumables[1] == null:
			person.money -= 120
			person.inventary.consumables[1] = Item.new("falakaxa")
		elif person.inventary.consumables[2] == null:
			person.money -= 120
			person.inventary.consumables[2] = Item.new("falakaxa")
		else:
			print("No slote")
