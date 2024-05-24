extends KinematicBody


var Person = preload("res://person.gd")
var person = Person.new("enemy")
var last_attack = null
var giv_money = 500
var is_move = false
var for_win_def = null
var is_attack = false
var tim_at = 0

func _ready():
	person.person_const["team"] = "right"
	for_win_def = get_node("/root/Spatial/KinematicBody").person.person_const["team"]

func _process(delta):
	if not is_move and not person.attack_bool:
		get_node("/root/Spatial/Enemy/person/AnimationPlayer").play("Размещённое действие]")
	if is_move:
		get_node("/root/Spatial/Enemy/person/AnimationPlayer").play("Размещённое действие]001")
		get_node("/root/Spatial/Enemy/person/AnimationPlayer").set_speed_scale(2)
	if person.attack_bool:
		get_node("/root/Spatial/Enemy/person/AnimationPlayer").play("Размещённое действие]003")
		get_node("/root/Spatial/Enemy/person/AnimationPlayer").set_speed_scale(person.person_stats["attack_speed"]/1.55)
		var sceen = get_node("/root/Spatial")
		tim_at+=delta
		if not person.attack(self, person.target["target_person"], "simple", sceen):
			is_move = false
	if tim_at >= person.person_stats["attack_speed"]/2:
		is_attack = true
		
		
	
	var target_position = Vector2(person.target["target"].x, person.target["target"].z)
	var global_pos = Vector2(global_position.x, global_position.z)
	var distance = target_position.distance_to(global_pos)
	if distance <= 0.1:
		is_move = false
	
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
			tim_at = 0
	
	is_move = false
	if person.attack(self, person.target["target_person"], "simple"):
		is_move = true
	
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
	
	$HUD.anchor_left = y_p-0.05
	$HUD.anchor_top = x_p-0.1
	$HUD/hp.max_value = person.person_stats["max_hp"]
	$HUD/hp.value = person.person_stats["hp"]
	$HUD/mana.max_value = person.person_stats["max_mana"]
	$HUD/mana.value = person.person_stats["mana"]
