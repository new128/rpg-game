extends KinematicBody

var target_position = Vector3.ZERO
var speed = 5.0

func _process(delta):
	# Обработка движения персонажа
	move_and_slide(Vector3.ZERO)

	# Перемещение к целевой позиции
	if target_position != Vector3.ZERO:
		var direction = (target_position - translation).normalized()
		move_and_slide(direction * speed)

func _input(event):
	# Обработка ввода от игрока
	if event is InputEventMouseButton and event.pressed:
		# Получение позиции, на которую нажал игрок
		var ray_origin = $"/root/Spatial/Camera".project_ray_origin(event.position)
		var ray_direction = $"/root/Spatial/Camera".project_ray_normal(event.position)

		var ray_cast = self.get_world().direct_space_state.intersect_ray(ray_origin, ray_origin + ray_direction * 1000)
		print(ray_origin, ray_direction)
		target_position = Vector3(1,1,1)
		if ray_cast and ray_cast.collider == self:
			target_position = ray_cast.position
			print(target_position)

