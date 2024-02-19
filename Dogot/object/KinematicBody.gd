extends KinematicBody

var target_position = Vector3.ZERO
var speed = 6
var rotation_threshold = 0.1
var rotation_speed = 5

func _process(delta):
	# Обработка движения персонажа
	move_and_slide(Vector3.ZERO)

	# Перемещение к целевой позиции
	if target_position != Vector3.ZERO:
		var direction = (target_position - translation).normalized()
		direction.y = 0
		move_and_slide(direction * speed)

func _input(event):
	# Обработка ввода от игрока
	if event is InputEventMouseButton and event.pressed and Input.is_action_pressed("right_click"):
		# Получение позиции, на которую нажал игрок
		var mouse_position = event.position
		var clicked_point = get_viewport().get_camera().project_ray_origin(mouse_position)
		var ray_end = get_viewport().get_camera().project_ray_normal(mouse_position) * 1000 + clicked_point
		
		var space_state = get_world().direct_space_state
		var result = space_state.intersect_ray(clicked_point, ray_end)
		print(result)
		if result:
			target_position = result.position
			print(target_position)

