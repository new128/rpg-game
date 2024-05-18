extends KinematicBody

var Person = preload("res://person.gd")
var person = Person.new("crip")
var last_attack = null
var giv_money = 50
var is_move = false
var for_win_def = null

func _ready():
	person.person_const["team"] = "right"
	for_win_def = get_node("/root/Spatial/KinematicBody").person.person_const["team"]

func _process(delta):
	person.effect()
	person.is_die()
	person.is_valid_stats()
	person.person_stats["time"] += delta
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
	if person.attack(self, person.target["target_person"], "simple"):
		is_move = true
	
	var cgp = global_transform.origin
	var cam = get_node("/root/Spatial/Play_camera")
	var x_p = (cam.transform.origin.x + 9.5 - cgp.x)/18.91
	var y_p = (33.62 - (cam.transform.origin.z + 16.81 - cgp.z))/33.62
	
	if for_win_def != person.person_const["team"]:
		$HUD/hp.modulate = Color(1, 0, 0)
	else:
		$HUD/hp.modulate = Color(0, 1, 0)
	
	$HUD.anchor_left = y_p-0.04
	$HUD.anchor_top = x_p#-0.1
	$HUD/hp.max_value = person.person_stats["max_hp"]
	$HUD/hp.value = person.person_stats["hp"]
	$HUD/hp.rect_size.y = 20
	$HUD/hp.rect_size.x = 140
	$HUD/mana.visible  = false
