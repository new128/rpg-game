class_name Inventory

var Item = preload("res://item.gd")
var Skill = preload("res://ability.gd")
var weapons = {"head" : null, "shoulders" : null, "left_hand" : null, "right_hand" : null, "body" :  null, "legs" : null}
var consumables = [0,0,0]

func _init(weapons_, consumables_):
	weapons = weapons_
	consumables = consumables_

func _add_ability(name, person):
	if consumables.find(0,0) != -1:
		if name == "falakaxa":
			consumables[consumables.find(0,0)] = Item.new({"name" : "falakaxa", "description" : "Flask from dota", "price" : 120,  "slote" : "consumables", "double_hands" : false, "rarity" : "regular", "dressed" : false}, {"regen_hp":30}, Skill.new("falakaxa", {"time":10,"target":"self"}))
			person.money -= 120
		if name == "pigeon":
			consumables[consumables.find(0,0)] = Item.new({"name" : "pigeon", "description" : "Claret from dota", "price" : 90,  "slote" : "consumables", "double_hands" : false, "rarity" : "regular", "dressed" : false}, {"regen_mana":20}, Skill.new("pigeon", {"time":10,"target":"self"}))
			person.money -= 90
		if name == "fufarik":
			consumables[consumables.find(0,0)] = Item.new({"name" : "fufarik", "description" : "fireman from dota", "price" : 80,  "slote" : "consumables", "double_hands" : false, "rarity" : "regular", "dressed" : false}, {"hp":100}, Skill.new("fufarik", {"time":"instantly","target":"self"}))
			person.money -= 80

func _use_ability(num_of_slote, person):
	for key in consumables[num_of_slote].characteristic:
		person.person_stats[key] += consumables[num_of_slote].characteristic[key]
	consumables[num_of_slote] = 0

func _wear_the_weapon(weapon):
	weapons[weapon.item_stats["slote"]] = weapon
func _add_w(we):
	weapons[we.item_stats["slote"]] = we
