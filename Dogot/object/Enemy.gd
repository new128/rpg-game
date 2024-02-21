extends KinematicBody


var Person = preload("res://person.gd")
var person = Person.new("paladin", null)

var pers_type = "enemy"

var target : Vector3 = Vector3.ZERO

var target_person = null

var die = false

var last_attack = null

var giv_money = 500

var type = "enemy"



func _ready():
	person.team = "right"


func _process(delta):
	
	
	effect()
	
	person.time += 1
	
	
	
	
	var direction_ = (target - translation).normalized()
	direction_.y = 0
	
	if direction_.length() > 0.1:
		var angle = atan2(direction_.x, direction_.z)
		rotation_degrees.y = angle * 180 / PI
	
	
	
	
	if target != Vector3.ZERO:
			var direction = (target - translation).normalized()
			direction.y = 0
			move_and_slide(direction * person.speed)
			
			
			
	
	person.attack(self, target_person)
	
	
	
	
	
	
	
	
	
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
	
	
	$HUD.anchor_left = y_p-0.04
	$HUD.anchor_top = x_p#-0.1
	
	$HUD/hp.max_value = person.max_hp
	$HUD/hp.value = person.hp
	$HUD/hp.rect_size.y = 20
	$HUD/hp.rect_size.x = 140
	$HUD/mana.visible  = false
	
	
	
	if person.hp <= 0:
		person.hp = 0
		die = true
		print("die")
	if person.hp >= person.max_hp:
		person.hp = person.max_hp
	if person.mana >= person.max_mana:
		person.mana = person.max_mana
		
		
func effect():
	person.hp += person.regen_hp/60.0

