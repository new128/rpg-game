extends KinematicBody

var target_position = Vector3.ZERO
var target_ = null
var speed = 10
var rotation_threshold = 0.1
var rotation_speed = 5
# Загрузка класса
var Person = preload("res://person.gd")
var Item = preload("res://item.gd") 
var Scill = preload("res://ability.gd")
#var person = Person.new("paladin",null)
var person = null
var back_object = null
var is_move = false
var type = "play_pers"
var pers_type = "play_pers"

var last_attack = null

var giv_money = 300

var die = false

var use_scill = null

var effects_p = []
var effects_time = []
var el_t = null


var sphere = MeshInstance.new()
var sphere_mesh = TorusMesh.new()

var time_skill1 = [false,0]
var time_skill2 = [false,0]
var time_skill3 = [false,0]
var time_skill4 = [false,0]
var time_skill5 = [false,0]
var time_skill6 = [false,0]

func _ready():
	
	
	
	
	var loadFile = File.new()
	loadFile.open('res://static/class.json',File.READ)
	var temp = parse_json(loadFile.get_as_text())
	loadFile.close()
	person = Person.new(temp["class"],null)

	
	person.team = "left"

func _process(delta):
	
	if time_skill1[0]:
		if time_skill1[1] <= 0:
			time_skill1[1] = 0
			time_skill1[0] = false
			get_node("/root/Spatial/Control/Skill1/Label2").visible = false
		get_node("/root/Spatial/Control/Skill1/Label2").text = String(int(time_skill1[1]))
		
		
		time_skill1[1]-=delta
	
	
	sphere.translation = self.translation
	var kin_bod = get_node("/root/Spatial/Control/Time")
	el_t = int(kin_bod.elapsed_time)
	
	person.time += delta
	
	# Обработка движения персонажа
	move_and_slide(Vector3.ZERO)
	for i in range(6):
		if person.skills[i]:
			var new_texture_path = "res://skills/" + person.skills[i].name + "/"+ person.skills[i].name + ".png"
			get_node("/root/Spatial/Control/Skill"+String(i+1)).icon = load(new_texture_path)
		else:get_node("/root/Spatial/Control/Skill"+String(i+1)).icon = null
	
	
	
	
	
	
	
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
	
	
	
	
	if person.attack_bool:
		var sceen = get_node("/root/Spatial")
		if not person.attack(self, back_object, sceen):
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
	control_node.connect("button_Q_pressed", self, "_on_button_Q_pressed")
	if event is InputEventKey and event.pressed and Input.is_action_pressed("Q"):
		_on_button_Q_pressed()
	control_node.connect("button_W_pressed", self, "_on_button_W_pressed")
	if event is InputEventKey and event.pressed and Input.is_action_pressed("W"):
		_on_button_W_pressed()
	control_node.connect("button_E_pressed", self, "_on_button_E_pressed")
	if event is InputEventKey and event.pressed and Input.is_action_pressed("E"):
		_on_button_E_pressed()
	control_node.connect("button_D_pressed", self, "_on_button_D_pressed")
	if event is InputEventKey and event.pressed and Input.is_action_pressed("D"):
		_on_button_D_pressed()
	control_node.connect("button_F_pressed", self, "_on_button_F_pressed")
	if event is InputEventKey and event.pressed and Input.is_action_pressed("F"):
		_on_button_F_pressed()
	control_node.connect("button_R_pressed", self, "_on_button_R_pressed")
	if event is InputEventKey and event.pressed and Input.is_action_pressed("R"):
		_on_button_R_pressed()
		
	control_node.connect("button_buy_falakaxa_pressed", self, "_on_button_buy_falakaxa_pressed")
	control_node.connect("button_buy_pigeon_pressed", self, "_on_button_buy_pigeon_pressed")
	control_node.connect("button_buy_weapon", self, "_on_button_buy_weapon")
	
	
	
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
					use_scill = null
					back_object = object
					is_move = false
					print("Yes")
					var sceen = get_node("/root/Spatial")
					if person.attack(self ,object, sceen):

					# Найти ближайшую точку на obj1 к obj2
						target_ = object
						target_position = object.global_transform.origin
						is_move = true
				
					return
			else:
				target_ = null
		#print(result)
		if result:
			target_position = result.position
			person.attack_bool = false
			is_move = true
			#print(target_position)
			
			
	if event is InputEventMouseButton and event.pressed and Input.is_action_pressed("left_click"):
		if use_scill != null:
			var mouse_position = event.position
			var clicked_point = get_viewport().get_camera().project_ray_origin(mouse_position)
			var ray_end = get_viewport().get_camera().project_ray_normal(mouse_position) * 1000 + clicked_point
			
			var space_state = get_world().direct_space_state
			var result = space_state.intersect_ray(clicked_point, ray_end)
			if result.has('collider'):
				var object = result.collider
				if object.person != null:
					if object.person.team != person.team:
						back_object = object
						is_move = false
						var sceen = get_node("/root/Spatial")
						var direction = (object.translation - translation).normalized()
						direction.y = 0
						if direction.length() > rotation_threshold:
							var angle = atan2(direction.x, direction.z)
							rotation_degrees.y = angle * 180 / PI
						if person.attack(self ,object, sceen, use_scill):
							time_skill1[0] = true
							#time_skill1[1] = use_scill.cd
							time_skill1[1] = 5
							get_node("/root/Spatial/Control/Skill1/Label2").visible = true
						use_scill = null
						sphere.visible = false
			
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
	var sphere = MeshInstance.new()
	var sphere_mesh = TorusMesh.new()
	sphere_mesh.outer_radius = 10
	sphere_mesh.inner_radius = 10-0.05
	sphere.mesh = sphere_mesh
	get_node("/root/Spatial").add_child(sphere)
	sphere.translation = self.translation
	if person.inventary.consumables[0]:
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
	if time_skill1[1] <= 0:
		if use_scill == null:
			if person.skills[0] != null:
				use_scill = person.skills[0]
				sphere_mesh.outer_radius = person.skills[0].dist
				sphere_mesh.inner_radius = person.skills[0].dist-0.05
				sphere.mesh = sphere_mesh
				get_node("/root/Spatial").add_child(sphere)
				sphere.translation = self.translation
				sphere.visible = true
				
				
		else:
			sphere.visible = false
			use_scill = null
func _on_button_W_pressed():
	pass
func _on_button_E_pressed():
	pass
func _on_button_D_pressed():
	pass
func _on_button_F_pressed():
	pass
func _on_button_R_pressed():
	pass
			
func _on_button_buy_falakaxa_pressed():
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
func _on_button_buy_pigeon_pressed():
	if person.money >= 90:
		if person.inventary.consumables[0] == null:
			person.money -= 90
			person.inventary.consumables[0] = Item.new("pigeon")
		elif person.inventary.consumables[1] == null:
			person.money -= 90
			person.inventary.consumables[1] = Item.new("pigeon")
		elif person.inventary.consumables[2] == null:
			person.money -= 90
			person.inventary.consumables[2] = Item.new("pigeon")
		else:
			print("No slote")
func _on_button_buy_weapon(name):
	person.money += person.inventary.weapon_r.price * 0.8
	print("You Sell >> "+name)
	if person.money >= Item.new(name).price:
		person.sell_item(name,"weapon_r")
		person.money -= 500
	else:
		person.money -= person.inventary.weapon_r.price * 0.8
