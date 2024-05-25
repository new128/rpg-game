extends Control

var file = File.new()

func _ready():
	$Button_Education.connect("pressed", self, "_on_button_pressed")
	$Button_Exit.connect("pressed", self, "_on_button_exit_pressed")
	$Button_MultiPlayer.connect("pressed", self, "_on_button_mp_pressed")
	OS.set_window_fullscreen(true)

func _on_button_pressed():
	file.open("res://static/type_g.txt", File.WRITE)
	file.store_string("1")
	file.close()
	get_tree().change_scene("res://ChooseClass.tscn")
	
func _on_button_mp_pressed():
	
	get_tree().change_scene("res://Cearch_game.tscn")

func _on_button_exit_pressed():
	get_tree().quit()


