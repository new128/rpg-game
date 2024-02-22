extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Replay.connect("pressed", self, "_on_button_pressed")
	$Menu.connect("pressed", self, "_on_button_menu_pressed")
	OS.set_window_fullscreen(true)

func _on_button_pressed():
	# Загрузка второй сцены
	get_tree().change_scene("res://object/main_sceen.tscn")
	
func _on_button_menu_pressed():
	get_tree().change_scene("res://object/Menu.tscn")


func new_win(team):
	print("TEAM")
	print(team)
	if team == "left":
		$Win.text = "Победа Сил Правых"
		$Der.text = "Вы не прошли обучени. Можете попробовать заново"
	if team == "right":
		$Win.text = "Победа Сил Левых"
		$Der.text = "Вы прошли обучени"
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
