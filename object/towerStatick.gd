extends StaticBody


var Person = preload("res://person.gd")
var person = Person.new("tower")
var last_attack = null
var giv_money = 300
var for_win_def = null
var is_attack = false
var tim_at = 0

func _ready():
	for_win_def = get_node("/root/Spatial/KinematicBody").person.person_const["team"]
	if get_name() == "LT1":
		person.person_const["team"] = "left"
	if get_name() == "RT1":
		person.person_const["team"] = "right"

func _process(delta):
	for_win_def = get_node("/root/Spatial/KinematicBody").person.person_const["team"]
	if person.attack_bool:
		tim_at+=delta
	if tim_at >= person.person_stats["attack_speed"]/2:
		is_attack = true
	
	
	
	person.effect()
	person.is_valid_stats()
	person.person_stats["time"] += delta
	person.is_die()
	
	var sceen = get_node("/root/Spatial")
	person.attack(self, person.target["target_person"], "simple", sceen)
	
	var cgp = global_transform.origin
	var screen_size = OS.get_screen_size()
	var cam = get_node("/root/Spatial/Play_camera")
	var pos = cam.position

	var x_pos = pos.x + 18 - cgp.x
	var y_pos = 31.62 - (pos.z + 16.81 - cgp.z)
	
	var x_p = 1*x_pos/18.91
	var y_p = 1*y_pos/33.62
	
	if for_win_def != person.person_const["team"]:
		$HUD/hp.modulate = Color(1, 0, 0)
	else:
		$HUD/hp.modulate = Color(0, 1, 0)
	
	$HUD.anchor_left = y_p-0.04
	$HUD.anchor_top = x_p-0.1
	$HUD/hp.max_value = person.person_stats["max_hp"]
	$HUD/hp.value = person.person_stats["hp"]
	$HUD/mana.visible = false
	$HUD/hp.rect_size.y = 20
	$HUD/hp.rect_size.x = 160
