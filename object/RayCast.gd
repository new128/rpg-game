extends Spatial

func _ready():
	# Подключаем сигнал body_entered к функции-обработчику
	$RayCast.connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	# Ваш код для обработки столкновения
	print("Луч столкнулся с чем-то!")
