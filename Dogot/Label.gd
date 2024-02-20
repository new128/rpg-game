extends Label

var elapsed_time: float = 0
var running: bool = true

func _process(delta):
	if running:
		elapsed_time += delta
		update_label()

func update_label():
	var elapsed_time_int = int(elapsed_time)
	var minutes: int = elapsed_time_int / 60
	var seconds: int = elapsed_time_int % 60
	text = String(minutes)+":"+String(seconds)

func start_timer():
	running = true

func stop_timer():
	running = false

func reset_timer():
	elapsed_time = 0
	update_label()
