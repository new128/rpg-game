extends KinematicBody

var rotation_threshold = 0.1
var rotation_speed = 5
var file = File.new()
var Person = preload("res://person.gd")
var Item = preload("res://item.gd")
var Inventory = preload("res://inventory.gd")
var Skill = preload("res://ability.gd")
var person = Person.new({"class" : "paladin", "pers_type" : "play_pers", "team" : "left"},
{"max_hp" : 1000, "hp": 1000, "max_mana": 200, "mana": 200, "regen_hp": 5, "regen_mana" : 1, "armor":10, "magic_damage_resist" : 30, "damage": 80, "attack_speed" : 2, "attack_radius" : 2.5, "speed" : 6,"max_skills" : 3, "lvl" : 1, "xp" : 0, "time" : 0},
null, Inventory.new({"head" : null, "shoulders" : null, "left_hand" : null, "right_hand" : null, "body" : null, "legs" : null}, [0,0,0]),500)
var is_move = false
var last_attack = null
var giv_money = 300
var effects_p = []
var effects_time = []
var el_t = 0

func _ready():
	file.open("res://class.txt", File.READ)
	var info = file.get_as_text()
	file.close()
	if info == "shooter":
		person = Person.new({"class" : "shooter", "pers_type" : "play_pers", "team" : "left"},
{"max_hp" : 600, "hp": 600, "max_mana": 500, "mana": 500, "regen_hp": 4, "regen_mana" : 4, "armor":2, "magic_damage_resist" : 15, "damage": 75, "attack_speed" : 1.5, "attack_radius" : 7.5, "speed" : 9,"max_skills" : 4, "lvl" : 1, "xp" : 0, "time" : 0},
null, Inventory.new({"head" : null, "shoulders" : null, "left_hand" : null, "right_hand" : null, "body" : null, "legs" : null}, [0,0,0]),700)
	elif info == "wizard":
		person = Person.new({"class" : "wizard", "pers_type" : "play_pers", "team" : "left"},
{"max_hp" : 400, "hp": 400, "max_mana": 700, "mana": 700, "regen_hp": 5, "regen_mana" : 1, "armor": 10, "magic_damage_resist" : 30, "damage": 90, "attack_speed" : 1, "attack_radius" : 10, "speed" : 4,"max_skills" : 3, "lvl" : 1, "xp" : 0, "time" : 0},
null, Inventory.new({"head" : null, "shoulders" : null, "left_hand" : null, "right_hand" : null, "body" : null, "legs" : null}, [0,0,0]),800)
	person.inventory._wear_the_weapon(Item.new({"name" : "sword_is_rusty","description" : "An ordinary sword for suckers", "price" : 500, "slote" : "right_hand", "double_hands" : false, "rarity" : "regular", "dressed" : false}, {"damage" : 10}, null))
	person.inventory._wear_the_weapon(Item.new({"name" : "tattered_mail","description" : "Regular armor for suckers", "price" : 500,"slote" : "body", "double_hands" : false, "rarity" : "regular", "dressed" : false}, {"armor" : 5, "hp" : 100}, null))
	person.inventory._wear_the_weapon(Item.new({"name" : "speed_boots","description" : "Regular armor for suckers", "price" : 500,"slote" : "legs", "double_hands" : false, "rarity" : "regular", "dressed" : false}, {"speed" : 1}, null))
	person.inventory.consumables[0] = Item.new({"name" : "falakaxa", "description" : "Flask from dota", "price" : 120,  "slote" : "consumables", "double_hands" : false, "rarity" : "regular", "dressed" : false}, {"regen_hp":30}, Skill.new("falakaxa", {"time":10,"target":"self","regen_hp":30}))
	person.inventory.consumables[1] = Item.new({"name" : "pigeon", "description" : "Claret from dota", "price" : 90,  "slote" : "consumables", "double_hands" : false, "rarity" : "regular", "dressed" : false}, {"regen_mana":20}, Skill.new("pigeon", {"time":10,"target":"self","regen_mana":20}))
	person.inventory.consumables[2] = Item.new({"name" : "fufarik", "description" : "fireman from dota", "price" : 80,  "slote" : "consumables", "double_hands" : false, "rarity" : "regular", "dressed" : false}, {"hp":100}, Skill.new("fufarik", {"time":"instantly","target":"self", "hp":100}))
func _process(delta):
	var kin_bod = get_node("/root/Spatial/Control/Time")
	el_t = int(kin_bod.elapsed_time)
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
		if not person.attack(self, person.target["target_person"]):
			is_move = false
	
	var cgp = global_transform.origin
	var cam = get_node("/root/Spatial/Play_camera")
	var x_p = (cam.position.x + 9.5 - cgp.x)/18.91
	var y_p = (33.62 - (cam.position.z + 16.81 - cgp.z))/33.62
	
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
		
	if event is InputEventKey and event.pressed and Input.is_action_pressed("Q"):
		_on_button_Q_pressed()
	
	control_node.connect("button_buy_falakaxa_pressed", self, "_on_button_buy_falakaxa_pressed")
	control_node.connect("button_buy_pigeon_pressed", self, "_on_button_buy_pigeon_pressed")
	
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
					if person.attack(self, object):
						person.target["target"] = object.global_transform.origin
						is_move = true
					return
		if result:
			person.target["target"] = result.position
			person.attack_bool = false
			is_move = true

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
	if person.money >= 120:
		person.inventory._add_ability("falakaxa", person)

func _on_button_buy_falakaxa_pressed():
	if person.money >= 120:
		person.inventory._add_ability("falakaxa", person)

func _on_button_buy_pigeon_pressed():
	if person.money >= 90:
		person.inventory._add_ability("pigeon", person)
