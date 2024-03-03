extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var loser = "right"
var game = null


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
func _process(delta):
	
	var file = File.new()
	var file_path = "user://win.txt"  # Путь к файлу (user:// используется для чтения из пользовательской директории)

	if file.open(file_path, File.READ) == OK:
		# Читаем текст из файла
		loser = file.get_as_text()
		# Закрываем файл после чтения
		file.close()
		
		# Выводим прочитанный текст
	if loser == "right":
		$Win.text = "Победа Сил левых"
		$Der.text = "Вы прошли обучение"
	if loser == "left":
		$Win.text = "Победа Сил правых"
		$Der.text = "Вы не прошли обучение. Можете прой1ти его заново"
		
