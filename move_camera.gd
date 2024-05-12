extends Camera

var movement_speed = 8.0
var is_mouse_dragging = false
var prev_mouse_pos = Vector2()

func _process(delta):
	# Получаем вектор направления от клавиш WASD
	var movement_vector = Vector3()

	if Input.is_action_pressed("right"):
		movement_vector.z += 1
	if Input.is_action_pressed("left"):
		movement_vector.z -= 1
	if Input.is_action_pressed("forward"):
		movement_vector.x += 1
	if Input.is_action_pressed("back"):
		movement_vector.x -= 1

	# Нормализуем вектор, чтобы скорость была одинаковой во всех направлениях
	movement_vector = movement_vector.normalized()
	# Перемещаем камеру
	transform.origin += movement_vector * (movement_speed+7) * delta

	# Обрабатываем движение мыши по зажатию средней кнопки
	if Input.is_action_pressed("midle_mouse"):
		if not is_mouse_dragging:
			is_mouse_dragging = true
			prev_mouse_pos = get_viewport().get_mouse_position()
		else:
			var delta_mouse = get_viewport().get_mouse_position() - prev_mouse_pos
			transform.origin += Vector3(delta_mouse.y, 0, -delta_mouse.x) * (movement_speed-5) * delta
			prev_mouse_pos = get_viewport().get_mouse_position()
	else:
		is_mouse_dragging = false
