extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var crips = []

var time = 0

var all_person = []

func _ready():
	var original_crip = $Crip
	crips.append(original_crip)
	all_person.append($KinematicBody)
	all_person.append($Crip)
	
# Создайте копии кинематического тела и 3D-модели
	var new_crip = original_crip.duplicate()

# Поместите копии в сцену (замените parent_node на ваш узел, к которому вы хотите прикрепить копии)
	add_child(new_crip)
	
	crips.append(new_crip)
	all_person.append(new_crip)
	new_crip.translation = Vector3(-30, 1.47, -50)
	
	



func _process(delta):
	
	for item in crips:
		var min_dist = INF
		var object_d = null
		
		for it in all_person:
			if it != item and it.pers_type != "enemy":
				var dist = item.global_transform.origin.distance_to(it.global_transform.origin)
				if dist <= min_dist:
					min_dist = dist
					object_d = it
		
		item.target = object_d.global_transform.origin
	
	
	
	
	time += 1
	if time % 60 == 1:
		$KinematicBody.person.money += 1.5
	
	for item in crips:
		if item.die:
			item.last_attack.money += item.giv_money
			item.queue_free()
			crips.erase(item)
