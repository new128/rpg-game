

var name = null
var description = null
var scil = {"time":null,"target":null}
var start = false
var end = false
var type = null
var damage = null
var type_damage = null
var dist = null
var cd = null
var mana = null

func _init(name_):
	name = name_
	damage = 200
	
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
	
	
	
	if name_ == "flask":
		scil["time"] = 10
		scil["target"] = "self"
		scil["reg_hp"] = +30
	if name_ == "clarety":
		scil["time"] = 10
		scil["target"] = "self"
		scil["reg_mana"] = +20
	if name_ == "fairik":
		scil["time"] = "instantly"
		scil["target"] = "self"
		scil["hp"] = +100
	if name_ == "mango":
		scil["time"] = "instantly"
		scil["target"] = "self"
		scil["mana"] = +100
		
