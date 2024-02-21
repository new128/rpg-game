extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var crips_and_tawers = [] # Объекты которые должны бить

var time = 0

var all_person = []

func _ready():
	var original_crip = $Crip
	crips_and_tawers.append(original_crip)
	crips_and_tawers.append($Tower_f)
	all_person.append($KinematicBody)
	all_person.append($Crip)
	all_person.append($Tower_f)
	
# Создайте копии кинематического тела и 3D-модели
	var new_crip2 = original_crip.duplicate()
	var new_crip3 = original_crip.duplicate()
	var new_crip4 = original_crip.duplicate()

# Поместите копии в сцену (замените parent_node на ваш узел, к которому вы хотите прикрепить копии)
	add_child(new_crip2)
	add_child(new_crip3)
	add_child(new_crip4)
	
	crips_and_tawers.append(new_crip2)
	all_person.append(new_crip2)
	crips_and_tawers.append(new_crip3)
	all_person.append(new_crip3)
	crips_and_tawers.append(new_crip4)
	all_person.append(new_crip4)
	new_crip2.translation = Vector3(5, 1.47, -5)
	new_crip3.translation = Vector3(10, 1.47, -10)
	new_crip4.translation = Vector3(-5, 1.47, 5)
	
	



func _process(delta):
	print(crips_and_tawers)
	print(all_person)
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
			item.last_attack.money += item.giv_money
			item.queue_free()
			if item in crips_and_tawers: crips_and_tawers.erase(item)
			all_person.erase(item)
