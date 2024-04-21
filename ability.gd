class_name Ability

var name = ""
var skill = {}       #{"time":null,"target":null,"regen_hp":null,"regen_mana":null}

func _init(name_, skill_):
	name = name_
	skill = skill_
	
#func _use_ability()
