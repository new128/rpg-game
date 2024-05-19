extends Control

var fileSave = File.new()
var info = ""

func _ready():
	$Button_Class1.connect("pressed", self, "_on_button1_pressed")
	$Button_Class2.connect("pressed", self, "_on_button2_pressed")
	$Button_Class3.connect("pressed", self, "_on_button3_pressed")
	OS.set_window_fullscreen(true)

func _write_info():
	fileSave.open("res://class.txt", File.WRITE)
	fileSave.store_string(info)
	fileSave.close()
	get_tree().change_scene("res://object/main_sceen.tscn")

func _on_button1_pressed():
	info = "paladin"
	_write_info()
func _on_button2_pressed():
	info = "shooter"
	_write_info()
func _on_button3_pressed():
	info = "wizard"
	_write_info()
