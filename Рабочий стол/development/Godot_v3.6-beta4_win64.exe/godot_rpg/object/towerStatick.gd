extends StaticBody


var Person = preload("res://person.gd")
var person = Person.new("tower", "tower_friend","team_hz",
{"max_hp" : 2000, "hp": 2000, "max_mana": 0, "mana": 0, "regen_hp": 0, "regen_mana" : 0, "armor":25, "magic_damage_resist" : 10, "damage": 80, "attack_speed" : 1, "attack_radius" : 6, "speed" : 0,"max_skills" : 0, "lvl" : 1, "xp" : 0, "time" : 0},
[], null, 0)
var target : Vector3 = Vector3.ZERO
var target_person = null
var die = false
var last_attack = null
var giv_money = 300


# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_name())
	if get_name() == "LT1":
		person.team = "left"
	if get_name() == "RT1":
		person.team = "right"


func _process(delta):
	effect()
	
	
	
	
	person.person_stats["time"] += 1
	
	person.attack(self, target_person)
	
	
	var cgp = global_transform.origin
	var screen_size = OS.get_screen_size()
	var cam = get_node("/root/Spatial/Play_camera")
	var pos = cam.position

	var x_pos = pos.x + 9.5 - cgp.x
	var y_pos = 33.62 - (pos.z + 16.81 - cgp.z)
	
	var x_p = 1*x_pos/18.91
	var y_p = 1*y_pos/33.62
	
	if person.person_stats["hp"] <= 0:
		person.person_stats["hp"] = 0
		die = true
		print("die")
	
	
	if get_node("/root/Spatial/KinematicBody").person.team != person.team:
		$HUD/hp.modulate = Color(1, 0, 0)
	
	
	$HUD.anchor_left = y_p-0.04
	$HUD.anchor_top = x_p-0.1
	
	$HUD/hp.max_value = person.person_stats["max_hp"]
	$HUD/hp.value = person.person_stats["hp"]
	$HUD/mana.visible = false
	$HUD/hp.rect_size.y = 20
	$HUD/hp.rect_size.x = 160


func effect():
	person.person_stats["hp"] += person.person_stats["regen_hp"]/60.0
