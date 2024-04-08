extends Control

func _ready():
	$Button_Education.connect("pressed", self, "_on_button_pressed")
	$Button_Exit.connect("pressed", self, "_on_button_exit_pressed")
	OS.set_window_fullscreen(true)

func _on_button_pressed():
	# Загрузка второй сцены
	get_tree().change_scene("res://ChooseClass.tscn")
	
func _on_button_exit_pressed():
	get_tree().quit()
