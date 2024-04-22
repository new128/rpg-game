class_name Inventory
""" 
				head
				shoulders
	left hand	body	right hand
				legs
"""

var Item = preload("res://item.gd")
var Skill = preload("res://ability.gd")
var weapons = {"head" : null, "shoulders" : null, "left_hand" : null, "right_hand" : null, "body" :  null, "legs" : null}
var consumables = [0,0,0]

func _init(weapons_, consumables_):
	weapons = weapons_
	consumables = consumables_
#	consumables[0] = Item.new("falakaxa", "Flask from dota", 120, "consumables", false, null, "regular", Skill.new("flask",  "Flask from dota" , {"time":10,"target":"self","regen_hp":30,"reg_mana":0}), false)
#	consumables[1] = Item.new("pigeon", "Claret from dota", 90, "consumables", false, null, "regular", Skill.new("clarety", "Claret from dota" , {"time":10,"target":"self","regen_hp":0,"reg_mana":20}), false)
#	consumables[2] = Item.new("fufarik", "fireman from dota", 80, "consumables", false, null , "regular", Skill.new("mango", "fireman from dota" , {"time":"instantly","target":"self","regen_hp":100,"reg_mana":0}), false)

func _add_ability(name):
	if consumables.find(0,0) != -1:
		if name == "falakaxa":
			consumables[consumables.find(0,0)] = Item.new({"name" : "falakaxa", "description" : "Flask from dota", "price" : 120,  "slote" : "consumables", "double_hands" : false, "rarity" : "regular", "dressed" : false}, {"regen_hp":30,"regen_mana":0}, Skill.new("falakaxa", {"time":10,"target":"self","regen_hp":30,"regen_mana":0}))
		if name == "pigeon":
			consumables[consumables.find(0,0)] = Item.new({"name" : "pigeon", "description" : "Claret from dota", "price" : 90,  "slote" : "consumables", "double_hands" : false, "rarity" : "regular", "dressed" : false}, {"regen_hp":0,"regen_mana":20}, Skill.new("pigeon", {"time":10,"target":"self", "regen_hp":0,"regen_mana":20}))
		if name == "fufarik":
			consumables[consumables.find(0,0)] = Item.new({"name" : "fufarik", "description" : "fireman from dota", "price" : 80,  "slote" : "consumables", "double_hands" : false, "rarity" : "regular", "dressed" : false}, {"regen_hp":100,"regen_mana":0}, Skill.new("fufarik", {"time":"instantly","target":"self", "regen_hp":100,"regen_mana":0}))
	else:
		print("NO SLOTE")

func _use_ability(num_of_slote, person):
	person.person_stats["regen_hp"] += consumables[num_of_slote].characteristic["regen_hp"]
	person.person_stats["regen_mana"] += consumables[num_of_slote].characteristic["regen_mana"]
	consumables[num_of_slote] = 0

func _wear_the_weapon(weapon):
	weapons[weapon.item_stats["slote"]] = weapon
	pass
