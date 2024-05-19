class_name Item



var Skill = preload("res://ability.gd")
var item_stats = {"name" : "", "description" : "", "price" : 0,  "slote" : "", "double_hands" : false, "rarity" : "", "dressed" : false, "type_attack" : null}
var characteristic = {"damage" : 0, "armor" : 0, "max_hp" :0, "max_mana" : 0, "regen_hp" : 0, "regen_mana" : 0, "magic_damage_resist" : 0, "speed" : 0, "attack_speed" : 0, "attack_radius" : 0}
var skill = null

func _init(name_):
	if name_ == "sword_is_rusty":
		item_stats["name"] = name_
		item_stats["description"] = "An ordinary sword for suckers" # Если что это всё переводчик
		item_stats["price"] = 500
		item_stats["slot"] = "right_hand"
		item_stats["double_hends"] = false
		characteristic["damage"] = +10
		item_stats["rarity"] = "regular"
		item_stats["type_attack"] = "melee"
		characteristic["attack_radius"] = 1.5
	if name_ == "steel_sword":  
		item_stats["name"] = name_
		item_stats["description"] = "steel sword" # Если что это всё переводчик
		item_stats["price"] = 200 #1000
		item_stats["slot"] = "right_hand"
		item_stats["double_hends"] = false
		characteristic["damage"] = +20
		item_stats["rarity"] = "unusual"
		item_stats["type_attack"] = "melee"
		characteristic["attack_radius"] = 2
	if name_ == "wooden_bow":
		item_stats["name"] = name_
		item_stats["description"] = "An ordinary bow"
		item_stats["price"] = 500
		item_stats["slot"] = "right_hand"
		item_stats["double_hends"] = false
		characteristic["damage"] = +10
		item_stats["rarity"] = "regular"
		item_stats["type_attack"] = "range"
		characteristic["attack_radius"] = 7
	if name_ == "slicing_bow":
		item_stats["name"] = name_
		item_stats["description"] = "slicing bow"
		item_stats["price"] = 200 #1000
		item_stats["slot"] = "right_hand"
		item_stats["double_hends"] = false
		characteristic["damage"] = +20
		item_stats["rarity"] = "unusual"
		item_stats["type_attack"] = "range"
		characteristic["attack_radius"] = 10
		skill = Skill.new("piercing_shot")
	if name_ == "regular_staff":
		item_stats["name"] = name_
		item_stats["description"] = "An ordinary staff"
		item_stats["price"] = 500
		item_stats["slot"] = "right_hand"
		item_stats["double_hends"] = false
		characteristic["damage"] = +10
		item_stats["rarity"] = "regular"
		item_stats["type_attack"] = "range"
		characteristic["attack_radius"] = 10
	if name_ == "tattered_mail": 
		item_stats["name"] = name_
		item_stats["description"] = "Regular armor for suckers" # Если что это всё переводчик
		item_stats["price"] = 500
		item_stats["slot"] = "body"
		item_stats["double_hends"] = false
		characteristic["armor"] = +5
		characteristic["max_hp"] = +100
		item_stats["rarity"] = "regular"
	if name_ == "speed_boots": 
		item_stats["name"] = name_
		item_stats["description"] = "Regular armor for suckers" # Если что это всё переводчик
		item_stats["price"] = 500
		item_stats["slot"] = "legs"
		item_stats["double_hends"] = false
		characteristic["speed"] = +1.5
		item_stats["rarity"] = "regular"
	
	if name_ == "falakaxa": 
		item_stats["name"] = name_
		item_stats["description"] = "Flask from dota" # Если что это всё переводчик
		item_stats["price"] = 120
		item_stats["slot"] = "consumables"
		item_stats["double_hends"] = false
		item_stats["rarity"] = "regular"
		skill = Skill.new("flask")
		characteristic["regen_hp"] = 30
	if name_ == "pigeon": 
		item_stats["name"] = name_
		item_stats["description"] = "Claret from dota" # Если что это всё переводчик
		item_stats["price"] = 90
		item_stats["slot"] = "consumables"
		item_stats["double_hends"] = false
		item_stats["rarity"] = "regular"
		skill = Skill.new("clarety")
		characteristic["regen_mana"]=20
	if name_ == "fufarik":
		item_stats["name"] = name_
		item_stats["description"] = "fireman from dota" # Если что это всё переводчик
		item_stats["price"] = 80
		item_stats["slot"] = "consumables"
		item_stats["double_hends"] = false
		item_stats["rarity"] = "regular"
		skill = Skill.new("fairik")
		characteristic["hp"] = 100
	if name_ == "magago":
		item_stats["name"] = name_
		item_stats["description"] = "mango from dota" # Если что это всё переводчик
		item_stats["price"] = 70
		item_stats["slot"] = "consumables"
		item_stats["double_hends"] = false
		item_stats["rarity"] = "regular"
		skill = Skill.new("mango")
		characteristic["mana"] = 100
