extends Area


func _on_Area_body_entered(body):
	# Обработка события входа объекта в область
	print("Объект вошел в область:", body)

func _on_Area_body_exited(body):
	# Обработка события выхода объекта из области
	print("Объект вышел из области:", body)
