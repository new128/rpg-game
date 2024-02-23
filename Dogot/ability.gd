

var name = null
var description = null
var scil = {"time":null,"target":null}
var start = false
var end = false


func _init(name_):
	name = name_
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
		
