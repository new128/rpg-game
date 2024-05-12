extends KinematicBody


var Person = preload("res://person.gd")
var person = Person.new({"class" : "paladin", "pers_type" : "enemy", "team" : "left"},
{"max_hp" : 1000, "hp": 1000, "max_mana": 200, "mana": 200, "regen_hp": 5, "regen_mana" : 1, "armor":10, "magic_damage_resist" : 30, "damage": 80, "attack_speed" : 2, "attack_radius" : 2.5, "speed" : 6,"max_skills" : 3, "lvl" : 1, "xp" : 0, "time" : 0},
null, null, 500)
var last_attack = null
var giv_money = 500
var is_move = false
var for_win_def = null

func _ready():
	person.person_const["team"] = "right"
	for_win_def = get_node("/root/Spatial/KinematicBody").person.person_const["team"]

func _process(delta):
	person.effect()
	person.is_die()
	person.is_valid_stats()
	person.person_stats["time"] += 1
	
	var direction_ = (person.target["target"] - translation).normalized()
	direction_.y = 0
	
	if direction_.length() > 0.1:
		var angle = atan2(direction_.x, direction_.z)
		rotation_degrees.y = angle * 180 / PI
	
	if person.target["target"] != Vector3.ZERO and is_move:
			var direction = (person.target["target"] - translation).normalized()
			direction.y = 0
			move_and_slide(direction * person.person_stats["speed"])
	
	is_move = false
	if person.attack(self, person.target["target_person"]):
		is_move = true
	
	var cgp = global_transform.origin
	var cam = get_node("/root/Spatial/Play_camera")
	var x_p = (cam.transform.origin.x + 9.5 - cgp.x)/18.91
	var y_p = (33.62 - (cam.transform.origin.z + 16.81 - cgp.z))/33.62
	
	if for_win_def != person.person_const["team"]:
		$HUD/hp.modulate = Color(1, 0, 0)
	
	$HUD.anchor_left = y_p-0.05
	$HUD.anchor_top = x_p-0.1
	$HUD/hp.max_value = person.person_stats["max_hp"]
	$HUD/hp.value = person.person_stats["hp"]
	$HUD/mana.max_value = person.person_stats["max_mana"]
	$HUD/mana.value = person.person_stats["mana"]
