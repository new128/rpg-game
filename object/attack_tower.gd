extends ProximityGroup


var Person = preload("res://person.gd")
#func _init(class_person_, pers_type_, max_hp_, hp_, max_mana_, mana_, regen_hp_, regen_mana_, armor_, magic_damage_resist_, damage_, attack_speed_, attack_radius_, speed_, skills_, xp_, lvl_, inventory_, money_ , max_skills_, time_):
var person = Person.new("tower", "tower_friend","team_hz",
{"max_hp" : 2000, "hp": 2000, "max_mana": 0, "mana": 0, "regen_hp": 0, "regen_mana" : 0, "armor":25, "magic_damage_resist" : 10, "damage": 80, "attack_speed" : 1, "attack_radius" : 6, "speed" : 0,"max_skills" : 0, "lvl" : 1, "xp" : 0, "time" : 0},
[], null, 0)

var target : Vector3 = Vector3.ZERO
var target_tower = null
var is_die = false
var last_attack = null
var giv_money = 300


# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_name())
	if get_name() == "Tower_f":
		person.team = "left"
	if get_name() == "Tower_r":
		person.team = "right"


func _process(delta):
	person.effect()
	
	
	if get_name() == "Tower_r":
		person = $StaticBody.person
	
	
	person.person_stats["time"] += 1
	person.attack(self, target_tower)
	
	var cgp = global_transform.origin
	var cam = get_node("/root/Spatial/Play_camera")
	var pos = cam.position
	var x_p = (pos.x + 9.5 - cgp.x)/18.91
	var y_p = (33.62 - (pos.z + 16.81 - cgp.z))/33.62
	
	is_die = person.is_die()
	
	$HUD.anchor_left = y_p-0.05
	$HUD.anchor_top = x_p-0.1
	
	$HUD/hp.max_value = person.person_stats["max_hp"]
	$HUD/hp.value = person.person_stats["hp"]
	print(get_name())
	print(person.person_stats["hp"])
	$HUD/mana.max_value = person.person_stats["max_mana"]
	$HUD/mana.value = person.person_stats["mana"]
