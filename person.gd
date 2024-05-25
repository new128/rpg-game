class_name PersonClass

var Inventory = preload("res://inventory.gd") 
var Item = preload("res://item.gd")
var Skill = preload("res://ability.gd")
var person_const = {"class" : "paladin", "pers_type" : "play_pers", "team" : "left"}
var person_stats = {"max_hp" : 1000, "hp": 1000, "max_mana": 200, "mana": 200, "regen_hp": 10, "regen_mana" : 1, "armor":10, "magic_damage_resist" : 30, "damage": 80, "attack_speed" : 2, "attack_radius" : 1, "speed" : 6,"max_skills" : 0, "lvl" : 1, "xp" : 0, "time" : 0, "t_a" : "melee"}
var skills = [null,null,null,null,null,null]
var inventory = Inventory.new({"head" : null, "shoulders" : null, "left_hand" : null, "right_hand" : null, "body" : null, "legs" : null}, [0,0,0])
var target = {"target" : Vector3.ZERO, "target_person" : null}
var is_die = false
var money = 500

func _init(name):
	if name == "paladin":
		person_const["class"] = "paladin"
		person_const["pers_type"] = "play_pers"
		person_const["team"] = ""
		person_stats["max_hp"] = 1000
		person_stats["max_mana"] = 200
		person_stats["regen_hp"] = 5
		person_stats["regen_mana"] = 1
		person_stats["armor"] = 10
		person_stats["magic_damage_resist"] = 30
		person_stats["damage"] = 80
		person_stats["attack_speed"] = 2
		person_stats["attack_radius"] = 3
		person_stats["speed"] = 11
		person_stats["t_a"] = "melee"
		inventory.weapons["right_hand"] = Item.new("sword_is_rusty")
		inventory.weapons["legs"] = Item.new("speed_boots")
		inventory.weapons["body"] = Item.new("tattered_mail")
		inventory.consumables[0] = Item.new("falakaxa")
		inventory.consumables[1] = Item.new("pigeon")
		inventory.consumables[2] = Item.new("fufarik")
	if name == "shooter":
		person_const["class"] = "shooter"
		person_const["pers_type"] = "play_pers"
		person_const["team"] = ""
		person_stats["max_hp"] = 1000
		person_stats["max_mana"] = 200
		person_stats["regen_hp"] = 5
		person_stats["regen_mana"] = 1
		person_stats["armor"] = 10
		person_stats["magic_damage_resist"] = 30
		person_stats["damage"] = 80
		person_stats["attack_speed"] = 0.1
		person_stats["attack_radius"] = 7
		person_stats["speed"] = 25
		person_stats["t_a"] = "range"
		inventory.weapons["right_hand"] = Item.new("sword_is_rusty")
		inventory.weapons["legs"] = Item.new("speed_boots")
		inventory.weapons["body"] = Item.new("tattered_mail")
		inventory.consumables[0] = Item.new("falakaxa")
		inventory.consumables[1] = Item.new("pigeon")
		inventory.consumables[2] = Item.new("fufarik")
	if name == "wizard":
		person_const["class"] = "wizard"
		person_const["pers_type"] = "play_pers"
		person_const["team"] = ""
		person_stats["max_hp"] = 1000
		person_stats["max_mana"] = 1000
		person_stats["mana"] = 1000
		person_stats["regen_hp"] = 5
		person_stats["regen_mana"] = 1
		person_stats["armor"] = 10
		person_stats["magic_damage_resist"] = 30
		person_stats["damage"] = 80
		person_stats["attack_speed"] = 2
		person_stats["attack_radius"] = 10
		person_stats["speed"] = 10
		person_stats["t_a"] = "range"
		inventory.weapons["right_hand"] = Item.new("sword_is_rusty")
		inventory.weapons["legs"] = Item.new("speed_boots")
		inventory.weapons["body"] = Item.new("tattered_mail")
		inventory.consumables[0] = Item.new("falakaxa")
		inventory.consumables[1] = Item.new("pigeon")
		inventory.consumables[2] = Item.new("fufarik")
		skills[0] = Skill.new("fire_ball")
		
	if name == "enemy":
		person_const["class"] = "paladin"
		person_const["pers_type"] = "enemy"
		person_const["team"] = "right"
		person_stats["max_hp"] = 1000
		person_stats["max_mana"] = 200
		person_stats["regen_hp"] = 5
		person_stats["regen_mana"] = 1
		person_stats["armor"] = 10
		person_stats["magic_damage_resist"] = 30
		person_stats["damage"] = 80
		person_stats["attack_speed"] = 2
		person_stats["attack_radius"] = 2.5
		person_stats["speed"] = 6
	
	if name == "crip":
		person_const["class"] = "crip"
		person_const["pers_type"] = "crip"
		person_const["team"] = "left"
		person_stats["max_hp"] = 1000
		person_stats["max_mana"] = 200
		person_stats["regen_hp"] = 5
		person_stats["regen_mana"] = 1
		person_stats["armor"] = 10
		person_stats["magic_damage_resist"] = 30
		person_stats["damage"] = 80
		person_stats["attack_speed"] = 2
		person_stats["attack_radius"] = 4
		person_stats["speed"] = 6
	
	
	if name == "tower":
		person_const["class"] = "tower"
		person_const["pers_type"] = "tower_friend"
		person_const["team"] = "left"
		person_stats["max_hp"] = 2000
		person_stats["hp"] = 2000
		person_stats["max_mana"] = 0
		person_stats["regen_hp"] = 0
		person_stats["regen_mana"] = 0
		person_stats["armor"] = 10
		person_stats["magic_damage_resist"] = 30
		person_stats["damage"] = 140
		person_stats["attack_speed"] = 1
		person_stats["attack_radius"] = 10
		person_stats["speed"] = 0
		person_stats["t_a"] = "range"

func taking_damage(type, damage):
	if type == "mag":
		person_stats["hp"] -= damage - damage * person_stats["magic_damage_resist"] / 100
	if type == "phis":
		person_stats["hp"] -= damage - person_stats["armor"]
	if type == "clear":
		person_stats["hp"] -= damage
		
var attack_bool = false

func attack(attack_object, target, type_attack, sceen = null, skill = null):
	if not is_instance_valid(target):
		return
	var obj1_position = Vector2(attack_object.global_transform.origin.x, attack_object.global_transform.origin.z)
	var obj2_position = Vector2(target.global_transform.origin.x, target.global_transform.origin.z)
	var dist = obj1_position.distance_to(obj2_position)
	
	
	
	if skill != null:
		if dist <= skill.dist:
			var sheel = load("res://skills/"+skill.name+"/"+skill.name+".tscn") 
			sheel = sheel.instance()
			sheel.translation = attack_object.translation
			sheel.self_ = attack_object
			sheel.target = target
			sheel.damage = skill.damage
			sheel.sceen = sceen
			sceen.add_child(sheel)
			return 5
	else:
		if dist <= person_stats["attack_radius"]:
			attack_bool = true
			if person_stats["time"] >= person_stats["attack_speed"] and type_attack == "simple":
				if attack_object.is_attack:
					if person_stats["t_a"] == "melee":
						if true:
							target.person.taking_damage("phis", person_stats["damage"])
						person_stats["time"] = 0
						target.last_attack = self
						attack_object.is_attack = false
						attack_object.tim_at = 0
					if person_stats["t_a"] == "range":
						var sheel = load("res://shells/strela/Strela.tscn") 
						sheel = sheel.instance()
						sheel.translation = attack_object.translation
						if person_const["class"] == "tower":
							sheel.translation.y += 3
						sheel.self_ = attack_object
						sheel.target = target
						sceen.add_child(sheel)
						person_stats["time"] = 0
						attack_object.is_attack = false
						attack_object.tim_at = 0
		else:
			return 5

func count_stat():
	for key_1 in inventory.weapons:
		if inventory.weapons[key_1] != null:
			for key_2 in inventory.weapons[key_1].characteristic:
				if inventory.weapons[key_1].item_stats["dressed"] == false:
					person_stats[key_2] += inventory.weapons[key_1].characteristic[key_2]
					for i in range(6):
						if skills[i] == null:
							skills[i] = inventory.weapons[key_1].skill
							break
					inventory.weapons[key_1].item_stats["dressed"] = true



func sell_item(name_item, slot):
	if inventory.weapons["right_hand"].skill:
		skills[skills.find(inventory.weapons["right_hand"].skill)] == null
	for key_2 in inventory.weapons["right_hand"].characteristic:
		if inventory.weapons["right_hand"].item_stats["dressed"] == true:
			person_stats[key_2] -= inventory.weapons["right_hand"].characteristic[key_2]
	inventory.weapons["right_hand"] = Item.new(name_item)



func is_die():
	if person_stats["hp"] <= 0:
		person_stats["hp"] = 0
		is_die = true
	return is_die

func is_valid_stats():
	if person_stats["mana"] < 0:
		person_stats["mana"] = 0
	if person_stats["hp"] > person_stats["max_hp"]:
		person_stats["hp"] = person_stats["max_hp"]
	if person_stats["mana"] > person_stats["max_mana"]:
		person_stats["mana"] = person_stats["max_mana"]

func effect():
	person_stats["hp"] += (person_stats["regen_hp"] / 60.0)
	person_stats["mana"] += (person_stats["regen_mana"] / 60.0)

func level_up():
	if person_stats["xp"] >= pow(person_stats["lvl"],2)*100:
		person_stats["lvl"] += 1
		person_stats["max_hp"] += 50
		person_stats["max_mana"] += 10
		person_stats["regen_hp"] += 2.5
		person_stats["regen_mana"] += 1
		person_stats["armor"] += 1
		person_stats["magic_damage_resist"] += 1
		person_stats["damage"] += 5
		person_stats["attack_speed"] -= 0.05
		person_stats["speed"] += 0.5
		person_stats["xp"] = 0
