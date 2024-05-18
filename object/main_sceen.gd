extends Spatial


var crips_and_towers = [] # Объекты которые должны бить
var time = 0
var all_person = []
var crip = null
var el_t = null
var back_el_t = 0
var end_game = false
var loser = null

func _ready():
	var file = File.new()
	var file_path = "user://win.txt"
	if file.open(file_path, File.WRITE) == OK:
		var text_to_write = "win"
		file.store_string(text_to_write)
		file.close()
		print("Текст успешно записан в файл.")
	
	crip = $Crip
	crips_and_towers.append($LT1)
	crips_and_towers.append($RT1)
	crips_and_towers.append($Enemy)
	crips_and_towers.append(crip)
	all_person.append($KinematicBody)
	all_person.append($Enemy)
	all_person.append($LT1)
	all_person.append($RT1)
	all_person.append(crip)
	
	for i in range(3):
		var new_crip = crip.duplicate()
		add_child(new_crip)
		crips_and_towers.append(new_crip)
		all_person.append(new_crip)
		new_crip.person.person_const["team"] = "right"
		new_crip.translation = Vector3(30+5*(i+1), 1.47, 60-5*(i+1))
	for j in range(4):
		var new_crip = crip.duplicate()
		add_child(new_crip)
		crips_and_towers.append(new_crip)
		all_person.append(new_crip)
		new_crip.person.person_const["team"] = "left"
		new_crip.translation = Vector3(-20-5*(j+1), 1.47, -70+5*(j+1))
	var el_t = int($Control/Time.elapsed_time)
	var back_el_t = el_t

func _process(delta):
	if end_game:
		get_tree().change_scene("res://object/Game_end.tscn")
	el_t = int($Control/Time.elapsed_time)
	if el_t % 60 == 0 and el_t - back_el_t > 1:
		for i in range(4):
			var new_crip = crips_and_towers[3].duplicate()
			add_child(new_crip)
			crips_and_towers.append(new_crip)
			all_person.append(new_crip)
			new_crip.person.person_const["team"] = "right"
			new_crip.translation = Vector3(30+5*(i+1), 1.47, 60-5*(i+1))
		for j in range(4):
			var new_crip = crips_and_towers[3].duplicate()
			add_child(new_crip)
			crips_and_towers.append(new_crip)
			all_person.append(new_crip)
			new_crip.person.person_const["team"] = "left"
			new_crip.translation = Vector3(-20-5*(j+1), 1.47, -70+5*(j+1))
		
		back_el_t = el_t
	
	for item in crips_and_towers:
		if item != null:
			var min_dist = INF
			var object_d = null
			if item.person.is_die() and item.person.person_const["team"] == "right" and item.person.person_const["class"] == "crip":
				all_person[0].person.money += 50
				all_person[0].person.person_stats["xp"] += 100
			elif item.person.is_die() and item.person.person_const["team"] == "right" and item.person.person_const["class"] == "tower":
				all_person[0].person.money += 500
				all_person[0].person.person_stats["xp"] += 1000
			for it in all_person:
				if it != null:
					if it != item and item.person.person_const["team"] != it.person.person_const["team"]:
						var dist = item.global_transform.origin.distance_to(it.global_transform.origin)
						if dist <= min_dist:
							min_dist = dist
							object_d = it
			if object_d != null:
				item.person.target["target"] = object_d.global_transform.origin
				item.person.target["target_person"] = object_d
	
	time += 1
	if time % 60 == 1 and get_node("/root/Spatial").has_node("KinematicBody"):
		$KinematicBody.person.money += 1.5
	
	for item in all_person:
		if item.person.is_die:
			if item.person.person_const["pers_type"] == "play_pers" or item.person.person_const["pers_type"] == "enemy" or item.person.person_const["pers_type"] == "tower":
				var file = File.new()
				var file_path = "user://win.txt"
				if file.open(file_path, File.WRITE) == OK:
					var text_to_write = item.person.person_const["team"]
					file.store_string(text_to_write)
					file.close()
					print("Текст успешно записан в файл.")
				end_game = true
			item.queue_free()
			if item in crips_and_towers: crips_and_towers.erase(item)
			all_person.erase(item)
