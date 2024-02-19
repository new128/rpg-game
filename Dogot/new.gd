extends RayCast

func _process(delta):
	if is_colliding():
		var collision_point = get_collision_point()
		var collided_object = get_collider()

		print("Точка столкновения: ", collision_point)
		print("Объект, с которым произошло столкновение: ", collided_object)
