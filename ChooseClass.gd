extends Node2D

func _ready():
	$Button_Class1.connect("pressed", self, "_on_button1_pressed")
	$Button_Class2.connect("pressed", self, "_on_button2_pressed")
	$Button_Class3.connect("pressed", self, "_on_button3_pressed")
	OS.set_window_fullscreen(true)

func _on_button1_pressed():
	get_tree().change_scene("res://object/main_sceen.tscn")
	
func _on_button2_pressed():
	get_tree().change_scene("res://object/main_sceen.tscn")
	
func _on_button3_pressed():
	get_tree().change_scene("res://object/main_sceen.tscn")
