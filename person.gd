class_name PersonClass

var Inventory = preload("res://inventory.gd") 
var Item = preload("res://item.gd") 
var class_person = "" # класс: ближник, дальник, маг и тд 
var pers_type = ""
var team = ""
var person_stats = {"max_hp" : 1000, "hp": 1000, "max_mana": 200, "mana": 200, "regen_hp": 10, "regen_mana" : 1, "armor":10, "magic_damage_resist" : 30, "damage": 80, "attack_speed" : 2, "attack_radius" : 2.5, "speed" : 6,"max_skills" : 0, "lvl" : 1, "xp" : 0, "time" : 0}
var skills = []
var inventory = Inventory.new({"head" : null, "shoulders" : null, "left_hand" : null, "right_hand" : null, "body" : null, "legs" : null}, [null,null,null])
var target = {"target" : Vector3.ZERO, "target_person" : null}
var is_die = false
var money = 500

func _init(class_person_, pers_type_, team_, person_stats_, skills_, inventory_, money_):
	class_person = class_person_
	pers_type = pers_type_
	team = team_
	person_stats = person_stats_
	skills = skills_
	inventory = inventory_
	money = money_


func taking_damage(type, damage):
	if type == "mag":
		person_stats["hp"] -= person_stats["damage"] - person_stats["damage"]*person_stats["magic_damage_resist"]/100
	if type == "phis":
		person_stats["hp"] -= person_stats["damage"] -person_stats["armor"]
	if type == "clear":
		person_stats["hp"] -= person_stats["damage"]
		
var attack_bool = false

func attack(attack_object, object):
	
	
	if not is_instance_valid(object):
		return
	print("attack")
	var obj1_position = Vector2(attack_object.global_transform.origin.x, attack_object.global_transform.origin.y)
	var obj2_position = Vector2(object.global_transform.origin.x, object.global_transform.origin.y)

	var dist = obj1_position.distance_to(obj2_position)
	
	attack_bool = true
	if object.person.class_person == "tower":
		dist -= 1
		
	if dist <= person_stats["attack_radius"]:
		print("aaaaaa")
		print(object.person.person_stats["hp"])
		if person_stats["time"] / 60 >= person_stats["attack_speed"]*4:
			
			object.person.taking_damage("phis", person_stats["damage"])
			person_stats["time"] = 0
			object.last_attack = self
	else:
		return 5
		
		
func count_stat():
	for key_1 in inventory.weapons:
		if inventory.weapons[key_1] != null:
			print(inventory.weapons[key_1].characteristic)
			for key_2 in inventory.weapons[key_1]:
				if not inventory.weapons[key_1].item_stats["dressed"]:
					person_stats[key_2] += inventory.body.characteristic[key_2]
			inventory.weapons[key_1].item_stats["dressed"] = true

func is_die():
	if person_stats["hp"] <= 0:
		person_stats["hp"] = 0
		print("is_die")
		is_die = true

func is_valid_stats():
	if person_stats["mana"] < 0:
		person_stats["mana"] = 0
		print("Dont mana")
	if person_stats["hp"] > person_stats["max_hp"]:
		person_stats["hp"] = person_stats["max_hp"]
	if person_stats["mana"] > person_stats["max_mana"]:
		person_stats["mana"] = person_stats["max_mana"]

func effect():
	person_stats["hp"] += (person_stats["regen_hp"] / 60.0)
	person_stats["mana"] += (person_stats["regen_mana"] / 60.0)
