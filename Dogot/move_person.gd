extends CSGCylinder


var movement_speed = 8.0
func _process(delta):
	# Получаем вектор направления от клавиш WASD
	var movement_vector = Vector3()

	if Input.is_action_pressed("right"):
		movement_vector.z -= 1
	if Input.is_action_pressed("left"):
		movement_vector.z += 1
	if Input.is_action_pressed("forward"):
		movement_vector.x -= 1
	if Input.is_action_pressed("back"):
		movement_vector.x += 1

	# Нормализуем вектор, чтобы скорость была одинаковой во всех направлениях
	movement_vector = movement_vector.normalized()

	# Перемещаем камеру
	translate(movement_vector * (movement_speed+7) * delta)
