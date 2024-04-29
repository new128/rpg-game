class_name Item


var item_stats = {"name" : "", "description" : "", "price" : 0,  "slote" : "", "double_hands" : false, "rarity" : "", "dressed" : false}
var characteristic = {"damage" : 0, "armor" : 0, "max_hp" :0, "max_mana" : 0, "regen_hp" : 0, "regen_mana" : 0, "magic_damage_resist" : 0, "speed" : 0, "attack_speed" : 0, "attack_radius" : 0}
var skill = null

func _init(item_stats_, characteristic_, skill_):
	item_stats = item_stats_
	characteristic = characteristic_
	skill = skill_
