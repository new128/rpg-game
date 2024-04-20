extends Button

func _ready():

	# Подключите обработчик события нажатия кнопки
	connect("pressed", self, "_on_button_pressed")

func _on_button_pressed():
	# Ваш код обработки события нажатия кнопки
	print("Кнопка с изображением нажата!")
