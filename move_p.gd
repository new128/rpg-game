extends KinematicBody  # Используем KinematicBody, если персонаж должен перемещаться

var target_position = Vector3.ZERO  # Здесь будем хранить целевые координаты

func _process(delta):
	# Обработка ввода (здесь предполагается использование левого клика мыши)
	if Input.is_action_just_pressed("right_click"):
		# Получаем координаты мыши в экранных координатах
		var mouse_position = get_viewport().get_mouse_position()
		# Преобразуем экранные координаты в мировые координаты
		var camera = get_node("Camera")  # Замените "/root/Scene/Camera" на путь к вашей камере в сцене
		var target_ray = camera.project_ray_origin(mouse_position)
		var target_point = camera.project_ray_normal(mouse_position) * 15  # Примерное расстояние от камеры

		# Устанавливаем целевые координаты для перемещения
		target_position = target_ray + target_point

	# Перемещение к целевым координатам
	if position.distance_to(target_position) > 0.1:  # Проверка, чтобы избежать мельчайших дрожаний
		position = position.linear_interpolate(target_position, 0.1)  # Используем линейную интерполяцию для плавного перемещения
