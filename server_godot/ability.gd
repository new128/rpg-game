class_name Ability

var name = ""
var skill = {"time":10,"target":"self"}
var type = null
var damage = null
var type_damage = null
var dist = null
var cd = null
var mana = null

func _init(name_):
	name = name_
	if name_ == "falakaxa":
		skill["time"] = 10
		skill["target"] = "self"
	if name_ == "pigeon":
		skill["time"] = 10
		skill["target"] = "self"
	if name_ == "fufarik":
		skill["time"] = "instantly"
		skill["target"] = "self"
	if name_ == "magago":
		skill["time"] = "instantly"
		skill["target"] = "self"
		
	if name_ == "fire_ball":
		type = "shell"
		type_damage = "mag"
		damage = 400
		dist = 10
		cd = 30
		mana = 300
		
	if name_ == "piercing_shot":
		type = "shell"
		type_damage = "mag"
		damage = 200
		dist = 15
		cd = 40
		mana = 200
