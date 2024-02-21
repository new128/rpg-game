extends StaticBody


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
	pass
