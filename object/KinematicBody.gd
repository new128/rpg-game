extends KinematicBody

var rotation_threshold = 0.1
var rotation_speed = 5
var file = File.new()
var Person = preload("res://person.gd")
var Item = preload("res://item.gd")
var Inventory = preload("res://inventory.gd")
var Skill = preload("res://ability.gd")
var person = null
var is_move = false
var last_attack = null
var giv_money = 300
var effects_p = []
var effects_time = []
var el_t = 0
var use_scill = null
var time_skill1 = [false,0]
var time_skill2 = [false,0]
var time_skill3 = [false,0]
var time_skill4 = [false,0]
var time_skill5 = [false,0]
var time_skill6 = [false,0]
var sphere = MeshInstance.new()
var sphere_mesh = TorusMesh.new()
var data_time_skill = [time_skill1,time_skill2,time_skill3,time_skill4,time_skill5,time_skill6]
var is_attack = false
var tim_at = 0

func _ready():
	file.open("res://class.txt", File.READ)
	var info = file.get_as_text()
	file.close()
	person = Person.new(info)
func _process(delta):
	if not is_move and not person.attack_bool:
		get_node("/root/Spatial/KinematicBody/person/AnimationPlayer").play("Размещённое действие]")
	if is_move:
		get_node("/root/Spatial/KinematicBody/person/AnimationPlayer").play("Размещённое действие]001")
		get_node("/root/Spatial/KinematicBody/person/AnimationPlayer").set_speed_scale(2)
		
	var target_position = Vector2(person.target["target"].x, person.target["target"].z)
	var global_pos = Vector2(global_position.x, global_position.z)
	var distance = target_position.distance_to(global_pos)
	if distance <= 0.5:
		is_move = false
	
	
	
	
	var j = 0
	for t_s in data_time_skill:
		if t_s[0]:
			if t_s[1] <= 0:
				t_s[1] = 0
				t_s[0] = false
				get_node("/root/Spatial/Control/Skill"+String(j+1)+"/Label2").visible = false
			get_node("/root/Spatial/Control/Skill"+String(j+1)+"/Label2").text = String(int(t_s[1]))
			t_s[1]-=delta
		j+=1
	
	
	
	sphere.translation = self.translation
	var kin_bod = get_node("/root/Spatial/Control/Time")
	el_t = int(kin_bod.elapsed_time)
	move_and_slide(Vector3.ZERO)
	for i in range(6):
		if person.skills[i]:
			var new_texture_path = "res://skills/" + person.skills[i].name + "/"+ person.skills[i].name + ".png"
			get_node("/root/Spatial/Control/Skill"+String(i+1)).icon = load(new_texture_path)
		else:get_node("/root/Spatial/Control/Skill"+String(i+1)).icon = null
	
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
	person.person_stats["time"] += delta
	
	if person.attack_bool:
		get_node("/root/Spatial/KinematicBody/person/AnimationPlayer").play("Размещённое действие]003")
		get_node("/root/Spatial/KinematicBody/person/AnimationPlayer").set_speed_scale(person.person_stats["attack_speed"]/1.55)
		var sceen = get_node("/root/Spatial")
		tim_at+=delta
		if not person.attack(self, person.target["target_person"], "simple", sceen):
			is_move = false
	if tim_at >= person.person_stats["attack_speed"]/2:
		is_attack = true
	var cgp = global_transform.origin
	var screen_size = OS.get_screen_size()
	var cam = get_node("/root/Spatial/Play_camera")
	var pos = cam.position

	var x_pos = pos.x + 18 - cgp.x
	var y_pos = 31.62 - (pos.z + 16.81 - cgp.z)
	
	var x_p = 1*x_pos/18.91
	var y_p = 1*y_pos/33.62

	
	$HUD.anchor_left = y_p-0.05
	$HUD.anchor_top = x_p-0.1
	$HUD/hp.max_value = person.person_stats["max_hp"]
	$HUD/hp.value = person.person_stats["hp"]
	$HUD/mana.max_value = person.person_stats["max_mana"]
	$HUD/mana.value = person.person_stats["mana"]
	
	var direction = (person.target["target"] - translation).normalized()
	direction.y = 0
	
	if direction.length() > rotation_threshold:
		var angle = atan2(direction.x, direction.z)
		rotation_degrees.y = angle * 180 / PI
	
	effects()
	person.is_die()
	person.is_valid_stats()
	person.level_up()
	
	if is_move:
		if person.target["target"] != Vector3.ZERO:
			move_and_slide(direction * person.person_stats["speed"])
			

func _input(event):
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
		var mouse_position = event.position
		var clicked_point = get_viewport().get_camera().project_ray_origin(mouse_position)
		var ray_end = get_viewport().get_camera().project_ray_normal(mouse_position) * 1000 + clicked_point
		var space_state = get_world().direct_space_state
		var result = space_state.intersect_ray(clicked_point, ray_end)
		if result.has('collider'):
			var object = result.collider
			person.target["target"] = result.position
			if object.person != null:
				if object.person.person_const["team"] != person.person_const["team"]:
					person.target["target_person"] = object
					is_move = false
					var sceen = get_node("/root/Spatial")
					if person.attack(self, object, "simple", sceen):
						person.target["target"] = object.global_transform.origin
						is_move = true
					return
		if result:
			person.target["target"] = result.position
			person.attack_bool = false
			tim_at = 0
			is_move = true
			
			
			
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
					if object.person.person_const["team"] != person.person_const["team"]:
						person.target["target_person"] = object
						is_move = false
						var sceen = get_node("/root/Spatial")
						var direction = (object.translation - translation).normalized()
						direction.y = 0
						if direction.length() > rotation_threshold:
							var angle = atan2(direction.x, direction.z)
							rotation_degrees.y = angle * 180 / PI
						if person.attack(self ,object, "skill",sceen, use_scill):
							person.person_stats["mana"] -= use_scill.mana
							time_skill1[0] = true
							time_skill1[1] = use_scill.cd
							get_node("/root/Spatial/Control/Skill1/Label2").visible = true
						else:get_node("/root/Spatial/Control").change_notice("Не в радиусе действия")
						use_scill = null
						sphere.visible = false

func effects():
	person.effect()
	for it in effects_p:
		if effects_time[effects_p.find(it.skill.skill)]+10 <= el_t:
			for key in it.characteristic:
				person.person_stats[key] -= it.characteristic[key]
			effects_p.erase(it)
			effects_time.erase(it)

func _on_button_Z_pressed():
	if person.inventory.consumables[0]:
		if String(person.inventory.consumables[0].skill.skill["time"]) != "instantly":
			effects_p.append(person.inventory.consumables[0])
			effects_time.append(el_t)
		person.inventory._use_ability(0, person)

func _on_button_X_pressed():
	if person.inventory.consumables[1]:
		if String(person.inventory.consumables[1].skill.skill["time"]) != "instantly":
			effects_p.append(person.inventory.consumables[1])
			effects_time.append(el_t)
		person.inventory._use_ability(1, person)

func _on_button_C_pressed():
	if person.inventory.consumables[2]:
		if String(person.inventory.consumables[2].skill.skill["time"]) != "instantly":
			effects_p.append(person.inventory.consumables[2])
			effects_time.append(el_t)
		person.inventory._use_ability(2, person)

func _on_button_Q_pressed():
	if time_skill1[1] <= 0:
		if use_scill == null:
			if person.skills[0] != null:
				if person.skills[0].mana <= person.person_stats["mana"]:
					use_scill = person.skills[0]
					sphere_mesh.outer_radius = person.skills[0].dist
					sphere_mesh.inner_radius = person.skills[0].dist-0.05
					sphere.mesh = sphere_mesh
					get_node("/root/Spatial").add_child(sphere)
					sphere.translation = self.translation
					sphere.visible = true
				else:get_node("/root/Spatial/Control").change_notice("Нет маны")
			else:get_node("/root/Spatial/Control").change_notice("Нет скила")
				
				
		else:
			sphere.visible = false
			use_scill = null
	else:get_node("/root/Spatial/Control").change_notice("Перезарядка")
func _on_button_W_pressed():
	if time_skill2[1] <= 0:
		if use_scill == null:
			if person.skills[1] != null:
				if person.skills[1].mana <= person.mana:
					use_scill = person.skills[1]
					sphere_mesh.outer_radius = person.skills[1].dist
					sphere_mesh.inner_radius = person.skills[1].dist-0.05
					sphere.mesh = sphere_mesh
					get_node("/root/Spatial").add_child(sphere)
					sphere.translation = self.translation
					sphere.visible = true
				else:get_node("/root/Spatial/Control").change_notice("Нет маны")
			else:get_node("/root/Spatial/Control").change_notice("Нет скила")
				
		else:
			sphere.visible = false
			use_scill = null
	else:get_node("/root/Spatial/Control").change_notice("Перезарядка")
func _on_button_E_pressed():
	if time_skill3[1] <= 0:
		if use_scill == null:
			if person.skills[2] != null:
				if person.skills[2].mana <= person.mana:
					use_scill = person.skills[2]
					sphere_mesh.outer_radius = person.skills[2].dist
					sphere_mesh.inner_radius = person.skills[2].dist-0.05
					sphere.mesh = sphere_mesh
					get_node("/root/Spatial").add_child(sphere)
					sphere.translation = self.translation
					sphere.visible = true
				else:get_node("/root/Spatial/Control").change_notice("Нет маны")
			else:get_node("/root/Spatial/Control").change_notice("Нет скила")
				
		else:
			sphere.visible = false
			use_scill = null
	else:get_node("/root/Spatial/Control").change_notice("Перезарядка")
func _on_button_D_pressed():
	if time_skill4[1] <= 0:
		if use_scill == null:
			if person.skills[3] != null:
				if person.skills[3].mana <= person.mana:
					use_scill = person.skills[3]
					sphere_mesh.outer_radius = person.skills[3].dist
					sphere_mesh.inner_radius = person.skills[3].dist-0.05
					sphere.mesh = sphere_mesh
					get_node("/root/Spatial").add_child(sphere)
					sphere.translation = self.translation
					sphere.visible = true
				else:get_node("/root/Spatial/Control").change_notice("Нет маны")
			else:get_node("/root/Spatial/Control").change_notice("Нет скила")
				
		else:
			sphere.visible = false
			use_scill = null
	else:get_node("/root/Spatial/Control").change_notice("Перезарядка")
func _on_button_F_pressed():
	if time_skill5[1] <= 0:
		if use_scill == null:
			if person.skills[4] != null:
				if person.skills[4].mana <= person.mana:
					use_scill = person.skills[4]
					sphere_mesh.outer_radius = person.skills[4].dist
					sphere_mesh.inner_radius = person.skills[4].dist-0.05
					sphere.mesh = sphere_mesh
					get_node("/root/Spatial").add_child(sphere)
					sphere.translation = self.translation
					sphere.visible = true
				else:get_node("/root/Spatial/Control").change_notice("Нет маны")
			else:get_node("/root/Spatial/Control").change_notice("Нет скила")
				
		else:
			sphere.visible = false
			use_scill = null
	else:get_node("/root/Spatial/Control").change_notice("Перезарядка")
func _on_button_R_pressed():
	if time_skill6[1] <= 0:
		if use_scill == null:
			if person.skills[5] != null:
				if person.skills[5].mana <= person.mana:
					use_scill = person.skills[5]
					sphere_mesh.outer_radius = person.skills[5].dist
					sphere_mesh.inner_radius = person.skills[5].dist-0.05
					sphere.mesh = sphere_mesh
					get_node("/root/Spatial").add_child(sphere)
					sphere.translation = self.translation
					sphere.visible = true
				else:get_node("/root/Spatial/Control").change_notice("Нет маны")
			else:get_node("/root/Spatial/Control").change_notice("Нет скила")
				
		else:
			sphere.visible = false
			use_scill = null
	else:get_node("/root/Spatial/Control").change_notice("Перезарядка")


func _on_button_buy_falakaxa_pressed():
	if person.money >= 120:
		person.inventory.consumables[person.inventory.consumables.find(0,0)] = Item.new("falakaxa")

func _on_button_buy_pigeon_pressed():
	if person.money >= 90:
		person.inventory.consumables[person.inventory.consumables.find(0,0)] = Item.new("pigeon")
		
func _on_button_buy_weapon(name):
	person.money += person.inventory.weapons["right_hand"].item_stats["price"] * 0.8
	print("You Sell >> "+name)
	if person.money >= Item.new(name).item_stats["price"]:
		person.sell_item(name,"weapon_r")
		person.money -= person.inventory.weapons["right_hand"].item_stats["price"]
	else:
		person.money -= person.inventory.weapons["right_hand"].price * 0.8
