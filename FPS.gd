extends Label

# Эта функция вызывается каждый кадр
func _process(delta):
	# Получаем текущий FPS
	var current_fps = Engine.get_frames_per_second()
	# Обновляем текст метки для отображения FPS
	text = str(current_fps) + " FPS"
