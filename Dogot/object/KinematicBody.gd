extends KinematicBody

var target_position = Vector3.ZERO
var speed = 6
var rotation_threshold = 0.1
var rotation_speed = 5
# Загрузка класса
var Person = preload("res://person.gd")
var Item = preload("res://item.gd") 
var person = Person.new("paladin", null)

func _process(delta):
	# Обработка движения персонажа
	move_and_slide(Vector3.ZERO)
	
	OS.set_window_fullscreen(true)
	
	
	
	
	
	
	effects()
	die()

	# Перемещение к целевой позиции
	if target_position != Vector3.ZERO:
		var direction = (target_position - translation).normalized()
		direction.y = 0
		move_and_slide(direction * speed)
		
		if direction.length() > rotation_threshold:
			var angle = atan2(direction.x, direction.z)
			rotation_degrees.y = angle * 180 / PI

func _input(event):
	# Обработка ввода от игрока
	var cgp = global_transform.origin
	var screen_size = OS.get_screen_size()
	var cam = get_node("/root/Spatial/Play_camera")
	var pos = cam.position

	var x_pos = pos.x + 9.5 - cgp.x
	var y_pos = 33.62 - (pos.z + 16.81 - cgp.z)
	
	var x_p = 1*x_pos/18.91
	var y_p = 1*y_pos/33.62
	
	print(x_p)
	print(y_p)
	
	$HUD.anchor_left = y_p-0.05
	$HUD.anchor_top = x_p-0.1
	
	
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
			
			
func effects():
	person.hp += person.regen_hp / 60
	person.mana += person.regen_mana / 60
	#person.hp += - 0.3
	#person.mana += -0.1
	
func die():
	if person.hp <= 0:
		person.hp = 0
		print("die")

