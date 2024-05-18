class_name Ability

var name = ""
var skill = {"time":10,"target":"self"}

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
