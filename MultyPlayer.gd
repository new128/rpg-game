extends Control
var search = false
var mes = ""
var time = 0
var t = false
func _ready():
	OS.set_window_fullscreen(true)



func _process(delta):
	if search:
		$Button.text = "Найдена"
		t = true
		get_tree().change_scene("res://Game1x1.tscn")
		
	if t:
		time+=delta
	if time >= 10:
		$Button.mes = "not"
