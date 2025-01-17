extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var crips_and_tawers = [] # Объекты которые должны бить

var time = 0

var all_person = []

var crip = null

var el_t = null
var back_el_t = 0

var end_game = false

var loser = null

func _ready():
	var file = File.new()
	var file_path = "user://win.txt"  # Путь к файлу (user:// используется для записи в пользовательскую директорию)

	if file.open(file_path, File.WRITE) == OK:
		# Записываем текст в файл
		var text_to_write = "win"
		file.store_string(text_to_write)

		# Закрываем файл после записи
		file.close()
		print("Текст успешно записан в файл.")
	
	
	crip = $Crip
	crips_and_tawers.append(crip)
	crips_and_tawers.append($Tower_f/LT1)
	crips_and_tawers.append($Tower_r/RT1)
	crips_and_tawers.append($Enemy)
	all_person.append($KinematicBody)
	all_person.append($Crip)
	all_person.append($Enemy)
	all_person.append($Tower_f/LT1)
	all_person.append($Tower_r/RT1)
	
# Создайте копии кинематического тела и 3D-модели
	var new_crip2 = crip.duplicate()
	var new_crip3 = crip.duplicate()
	var new_crip4 = crip.duplicate()
	
	var new_crip5 = crip.duplicate()
	var new_crip6 = crip.duplicate()
	var new_crip7 = crip.duplicate()
	var new_crip8 = crip.duplicate()
	
	crip = crip.duplicate()

# Поместите копии в сцену (замените parent_node на ваш узел, к которому вы хотите прикрепить копии)
# От препа: Возможно, сделать это циклом?
	add_child(new_crip2)
	add_child(new_crip3)
	add_child(new_crip4)
	
	add_child(new_crip5)
	add_child(new_crip6)
	add_child(new_crip7)
	add_child(new_crip8)
	
	crips_and_tawers.append(new_crip2)
	all_person.append(new_crip2)
	crips_and_tawers.append(new_crip3)
	all_person.append(new_crip3)
	crips_and_tawers.append(new_crip4)
	all_person.append(new_crip4)
	
	crips_and_tawers.append(new_crip5)
	all_person.append(new_crip5)
	crips_and_tawers.append(new_crip6)
	all_person.append(new_crip6)
	crips_and_tawers.append(new_crip7)
	all_person.append(new_crip7)
	crips_and_tawers.append(new_crip8)
	all_person.append(new_crip8)
	
	
	new_crip2.translation = Vector3(35, 1.47, 55)
	new_crip3.translation = Vector3(40, 1.47, 50)
	new_crip4.translation = Vector3(25, 1.47, 65)
	
	new_crip5.translation = Vector3(-30, 1.47, -60)
	new_crip5.rotation_degrees.y = 25
	new_crip6.translation = Vector3(-25, 1.47, -65)
	new_crip6.rotation_degrees.y = 25
	new_crip7.translation = Vector3(-20, 1.47, -70)
	new_crip7.rotation_degrees.y = 25
	new_crip8.translation = Vector3(-35, 1.47, -55)
	new_crip8.rotation_degrees.y = 25
	
	
	new_crip5.person.team = "left"
	new_crip6.person.team = "left"
	new_crip7.person.team = "left"
	new_crip8.person.team = "left"
	
	
	var el_t = int($Control/Time.elapsed_time)
	var back_el_t = el_t




func _process(delta):
	if end_game:
		get_tree().change_scene("res://object/Game_end.tscn")
	# Новая волна крипов
	el_t = int($Control/Time.elapsed_time)
	if el_t % 60 == 0 and el_t - back_el_t > 1:
		# От препа: список из крипов?
		var new_crip2 = crip.duplicate()
		var new_crip1 = crip.duplicate()
		var new_crip3 = crip.duplicate()
		var new_crip4 = crip.duplicate()
		
		var new_crip5 = crip.duplicate()
		var new_crip6 = crip.duplicate()
		var new_crip7 = crip.duplicate()
		var new_crip8 = crip.duplicate()
		
		add_child(new_crip2)
		add_child(new_crip1)
		add_child(new_crip3)
		add_child(new_crip4)
		
		add_child(new_crip5)
		add_child(new_crip6)
		add_child(new_crip7)
		add_child(new_crip8)
		
		crips_and_tawers.append(new_crip2)
		all_person.append(new_crip2)
		crips_and_tawers.append(new_crip1)
		all_person.append(new_crip1)
		crips_and_tawers.append(new_crip3)
		all_person.append(new_crip3)
		crips_and_tawers.append(new_crip4)
		all_person.append(new_crip4)
		
		crips_and_tawers.append(new_crip5)
		all_person.append(new_crip5)
		crips_and_tawers.append(new_crip6)
		all_person.append(new_crip6)
		crips_and_tawers.append(new_crip7)
		all_person.append(new_crip7)
		crips_and_tawers.append(new_crip8)
		all_person.append(new_crip8)
		
		new_crip2.translation = Vector3(35, 1.47, 55)
		new_crip1.translation = Vector3(30, 1.47, 60)
		new_crip3.translation = Vector3(40, 1.47, 50)
		new_crip4.translation = Vector3(25, 1.47, 65)
		
		
		new_crip5.translation = Vector3(-30, 1.47, -60)
		new_crip5.rotation_degrees.y = 25
		new_crip6.translation = Vector3(-25, 1.47, -65)
		new_crip6.rotation_degrees.y = 25
		new_crip7.translation = Vector3(-20, 1.47, -70)
		new_crip7.rotation_degrees.y = 25
		new_crip8.translation = Vector3(-35, 1.47, -55)
		new_crip8.rotation_degrees.y = 25
		
		
		new_crip5.person.team = "left"
		new_crip6.person.team = "left"
		new_crip7.person.team = "left"
		new_crip8.person.team = "left"
		
		
		
		
		
		
		back_el_t = el_t
	
	
	
	
	
	
	
	#print(crips_and_tawers)
	#print(all_person)
	for item in crips_and_tawers:
		if item != null:
			var min_dist = INF
			var object_d = null
			
			for it in all_person:
				if it != null:
					if it != item and item.person.team != it.person.team:
						var dist = item.global_transform.origin.distance_to(it.global_transform.origin)
						if dist <= min_dist:
							min_dist = dist
							object_d = it
			if object_d != null:
				item.target = object_d.global_transform.origin
				item.target_person = object_d
				print(object_d.name)
	
	
	
	
	time += 1
	if time % 60 == 1 and get_node("/root/Spatial").has_node("KinematicBody"):
		
		$KinematicBody.person.money += 1.5
	
	for item in all_person:
		if item.die:
			if item.person.pers_type == "play_pers" or item.person.pers_type == "enemy" or item.person.pers_type == "tower":
				var file = File.new()
				var file_path = "user://win.txt"  # Путь к файлу (user:// используется для записи в пользовательскую директорию)

				if file.open(file_path, File.WRITE) == OK:
					# Записываем текст в файл
					var text_to_write = item.person.team
					file.store_string(text_to_write)

					# Закрываем файл после записи
					file.close()
					print("Текст успешно записан в файл.")
				end_game = true
			item.last_attack.money += item.giv_money
			item.queue_free()
			if item in crips_and_tawers: crips_and_tawers.erase(item)
			all_person.erase(item)
