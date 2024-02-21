extends ProximityGroup


var Person = preload("res://person.gd")
var person = Person.new("tower", null)

var pers_type = "tower_frend"

var target : Vector3 = Vector3.ZERO

var target_person = null

var die = false

var last_attack = null

var giv_money = 300

var type = "tower_frend"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var cgp = global_transform.origin
	var screen_size = OS.get_screen_size()
	var cam = get_node("/root/Spatial/Play_camera")
	var pos = cam.position

	var x_pos = pos.x + 9.5 - cgp.x
	var y_pos = 33.62 - (pos.z + 16.81 - cgp.z)
	
	var x_p = 1*x_pos/18.91
	var y_p = 1*y_pos/33.62
	
	
	$HUD.anchor_left = y_p-0.05
	$HUD.anchor_top = x_p-0.1
	
	$HUD/hp.max_value = person.max_hp
	$HUD/hp.value = person.hp
	$HUD/mana.max_value = person.max_mana
	$HUD/mana.value = person.mana
