class_name Item



var Skill = preload("res://ability.gd")
var item_stats = {"name" : "", "description" : "", "price" : 0,  "slote" : "", "double_hands" : false, "rarity" : "", "dressed" : false}
var characteristic = {"damage" : 0, "armor" : 0, "max_hp" :0, "max_mana" : 0, "regen_hp" : 0, "regen_mana" : 0, "magic_damage_resist" : 0, "speed" : 0, "attack_speed" : 0, "attack_radius" : 0}
var skill = null

func _init(name_):
	if name_ == "sword_is_rusty":
		item_stats = {"name" : name_, "description" : "An ordinary sword", "price" : 500,  "slote" : "right_hand", "double_hands" : false, "rarity" : "regular", "dressed" : false}
		characteristic["damage"] = 10
	if name_ == "steel_sword":  
		item_stats = {"name" : name_, "description" : "steel sword", "price" : 1000,  "slote" : "right_hand", "double_hands" : false, "rarity" : "unusual", "dressed" : false}
		characteristic = {"damage": 20, "attack_radius": 0.5}
	if name_ == "wooden_bow":
		item_stats = {"name" : name_, "description" : "An ordinary bow", "price" : 500,  "slote" : "right_hand", "double_hands" : false, "rarity" : "regular", "dressed" : false}
		characteristic["damage"] = 10
	if name_ == "slicing_bow":
		item_stats = {"name" : name_, "description" : "slicing bow", "price" : 1000,  "slote" : "right_hand", "double_hands" : false, "rarity" : "unusual", "dressed" : false}
		characteristic = {"damage": 20, "attack_radius": 2}
		skill = Skill.new("piercing_shot")
	if name_ == "regular_staff":
		item_stats = {"name" : name_, "description" : "An ordinary staff", "price" : 500,  "slote" : "right_hand", "double_hands" : false, "rarity" : "regular", "dressed" : false}
		characteristic["damage"] = 10
	if name_ == "tattered_mail": 
		item_stats = {"name" : name_, "description" : "Regular armor", "price" : 500,  "slote" : "body", "double_hands" : false, "rarity" : "regular", "dressed" : false}
		characteristic = {"armor": 5, "max_hp": 100}
	if name_ == "speed_boots": 
		item_stats = {"name" : name_, "description" : "Regular armor", "price" : 500,  "slote" : "legs", "double_hands" : false, "rarity" : "regular", "dressed" : false}
		characteristic["speed"] = +1.5
	if name_ == "falakaxa": 
		item_stats = {"name" : name_, "description" : "Flask from dota", "price" : 120,  "slote" : "consumables", "double_hands" : false, "rarity" : "regular", "dressed" : false}
		characteristic["regen_hp"] = 30
		skill = Skill.new("flask")
	if name_ == "pigeon": 
		item_stats = {"name" : name_, "description" : "Claret from dota", "price" : 90,  "slote" : "consumables", "double_hands" : false, "rarity" : "regular", "dressed" : false}
		characteristic["regen_mana"] = 20
		skill = Skill.new("clarety")
	if name_ == "fufarik":
		item_stats = {"name" : name_, "description" : "fireman from dota", "price" : 80,  "slote" : "consumables", "double_hands" : false, "rarity" : "regular", "dressed" : false}
		characteristic["hp"] = 100
		skill = Skill.new("fairik")
	if name_ == "magago":
		item_stats = {"name" : name_, "description" : "mango from dota", "price" : 70,  "slote" : "consumables", "double_hands" : false, "rarity" : "regular", "dressed" : false}
		characteristic["mana"] = 100
		skill = Skill.new("mango")
