extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	var original_crip = $Crip

# Создайте копии кинематического тела и 3D-модели
	var new_crip = original_crip.duplicate()

# Поместите копии в сцену (замените parent_node на ваш узел, к которому вы хотите прикрепить копии)
	add_child(new_crip)

	new_crip.translation = Vector3(-30, 1.47, -50)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
