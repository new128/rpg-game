extends Control

var search = false
var mes = ""
var time = 0
var t = false
var file = File.new()

func _ready():
	OS.set_window_fullscreen(true)
	$Button2.connect("pressed", self, "_on_Button2_button_down")



func _process(delta):
	if search:
		$Button.text = "Найдена"
		t = true
		file.open("res://static/type_g.txt", File.WRITE)
		file.store_string("2")
		file.close()
		get_tree().change_scene("res://ChooseClass.tscn")
		
	if t:
		time+=delta
	if time >= 10:
		$Button.mes = "not"


func _on_Button2_button_down():
	file.open("res://static/type_g.txt", File.WRITE)
	file.store_string("2")
	file.close()
	get_tree().change_scene("res://ChooseClass.tscn")
