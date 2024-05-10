extends Control

var loser = "right"
var game = null

func _ready():
	$Replay.connect("pressed", self, "_on_button_pressed")
	$Menu.connect("pressed", self, "_on_button_menu_pressed")
	OS.set_window_fullscreen(true)

func _on_button_pressed():
	get_tree().change_scene("res://object/main_sceen.tscn")
	
func _on_button_menu_pressed():
	get_tree().change_scene("res://object/Menu.tscn")

func new_win(team):
	if team == "left":
		$Win.text = "Победа Сил Правых"
		$Der.text = "Вы не прошли обучени. Можете попробовать заново"
	if team == "right":
		$Win.text = "Победа Сил Левых"
		$Der.text = "Вы прошли обучени"

func _process(delta):
	var file = File.new()
	var file_path = "user://win.txt"

	if file.open(file_path, File.READ) == OK:
		loser = file.get_as_text()
		file.close()
	if loser == "right":
		$Win.text = "Победа Сил левых"
		$Der.text = "Вы прошли обучение"
	if loser == "left":
		$Win.text = "Победа Сил правых"
		$Der.text = "Вы не прошли обучение. Можете пройти его заново"
