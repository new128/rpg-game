extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var crips = []

func _ready():
	var original_crip = $Crip
	crips.append(original_crip)
# Создайте копии кинематического тела и 3D-модели
	var new_crip = original_crip.duplicate()

# Поместите копии в сцену (замените parent_node на ваш узел, к которому вы хотите прикрепить копии)
	add_child(new_crip)
	
	crips.append(new_crip)

	new_crip.translation = Vector3(-30, 1.47, -50)
	
	



func _process(delta):
	for item in crips:
		if item.die:
			item.queue_free()
			crips.erase(item)
