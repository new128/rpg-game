extends Control

func _ready():
	$Button_Education.connect("pressed", self, "_on_button_pressed")
	OS.set_window_fullscreen(true)

func _on_button_pressed():
	# Загрузка второй сцены
	get_tree().change_scene("res://object/main_sceen.tscn")

