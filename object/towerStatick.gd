extends StaticBody


var Person = preload("res://person.gd")
var person = Person.new({"class" : "tower", "pers_type" : "tower_friend", "team" : "left"},
{"max_hp" : 2000, "hp": 2000, "max_mana": 0, "mana": 0, "regen_hp": 0, "regen_mana" : 0, "armor":25, "magic_damage_resist" : 10, "damage": 80, "attack_speed" : 1, "attack_radius" : 6, "speed" : 0,"max_skills" : 0, "lvl" : 1, "xp" : 0, "time" : 0},
[], null, 0)
var last_attack = null
var giv_money = 300
var for_win_def = null

func _ready():
	for_win_def = get_node("/root/Spatial/KinematicBody").person.person_const["team"]
	if get_name() == "LT1":
		person.person_const["team"] = "left"
	if get_name() == "RT1":
		person.person_const["team"] = "right"

func _process(delta):
	person.effect()
	person.person_stats["time"] += 1
	person.is_die()
	person.attack(self, person.target["target_person"])
	
	var cgp = global_transform.origin
	var cam = get_node("/root/Spatial/Play_camera")
	var x_p = (cam.position.x + 9.5 - cgp.x)/18.91
	var y_p = (33.62 - (cam.position.z + 16.81 - cgp.z))/33.62
	
	if for_win_def != person.person_const["team"]:
		$HUD/hp.modulate = Color(1, 0, 0)
	
	$HUD.anchor_left = y_p-0.04
	$HUD.anchor_top = x_p-0.1
	$HUD/hp.max_value = person.person_stats["max_hp"]
	$HUD/hp.value = person.person_stats["hp"]
	$HUD/mana.visible = false
	$HUD/hp.rect_size.y = 20
	$HUD/hp.rect_size.x = 160
