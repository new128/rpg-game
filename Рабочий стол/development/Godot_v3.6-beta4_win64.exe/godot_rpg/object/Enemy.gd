extends KinematicBody


var Person = preload("res://person.gd")
#func _init(class_person_, pers_type_, max_hp_, hp_, max_mana_, mana_, regen_hp_, regen_mana_, armor_, magic_damage_resist_, damage_, attack_speed_, attack_radius_, speed_, skills_, xp_, lvl_, inventory_, money_ , max_skills_, time_):
var person = Person.new("paladin", "enemy","team_hz",
{"max_hp" : 1000, "hp": 1000, "max_mana": 200, "mana": 200, "regen_hp": 5, "regen_mana" : 1, "armor":10, "magic_damage_resist" : 30, "damage": 80, "attack_speed" : 2, "attack_radius" : 2.5, "speed" : 6,"max_skills" : 3, "lvl" : 1, "xp" : 0, "time" : 0},
null, null, 500)
var target : Vector3 = Vector3.ZERO
var target_person = null
var die = false
var last_attack = null
var giv_money = 500
var is_move = false



func _ready():
	person.team = "right"
	person.pers_type = "enemy"


func _process(delta):
	person.effect()
	
	person.person_stats["time"] += 1
	
	
	
	
	var direction_ = (target - translation).normalized()
	direction_.y = 0
	
	if direction_.length() > 0.1:
		var angle = atan2(direction_.x, direction_.z)
		rotation_degrees.y = angle * 180 / PI
	
	
	
	
	if target != Vector3.ZERO and is_move:
			var direction = (target - translation).normalized()
			direction.y = 0
			move_and_slide(direction * person.person_stats["speed"])
			
			
			
	
	is_move = false
	if person.attack(self, target_person):
		is_move = true
	
	
	var cgp = global_transform.origin
	var screen_size = OS.get_screen_size()
	var cam = get_node("/root/Spatial/Play_camera")
	var pos = cam.position

	var x_pos = pos.x + 9.5 - cgp.x
	var y_pos = 33.62 - (pos.z + 16.81 - cgp.z)
	
	var x_p = 1*x_pos/18.91
	var y_p = 1*y_pos/33.62
	
	if get_node("/root/Spatial/KinematicBody").person.team != person.team:
		$HUD/hp.modulate = Color(1, 0, 0)
	
	
	$HUD.anchor_left = y_p-0.05
	$HUD.anchor_top = x_p-0.1
	
	$HUD/hp.max_value = person.person_stats["max_hp"]
	$HUD/hp.value = person.person_stats["hp"]
	
	$HUD/mana.max_value = person.person_stats["max_mana"]
	$HUD/mana.value = person.person_stats["mana"]
	
	
	if person.person_stats["hp"] <= 0:
		person.person_stats["hp"] = 0
		die = true
		print("die")
	if person.person_stats["hp"] >= person.person_stats["max_hp"]:
		person.person_stats["hp"] = person.person_stats["max_hp"]
	if person.person_stats["mana"] >= person.person_stats["max_mana"]:
		person.person_stats["mana"] = person.person_stats["max_mana"]
