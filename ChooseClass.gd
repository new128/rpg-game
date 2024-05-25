extends Node2D

var fileSave = File.new()
var file = File.new()
var info = ""
var client = NetworkedMultiplayerENet.new()

func _ready():
	client.create_client("127.0.0.1", 4242)
	get_tree().set_network_peer(client)
	print("Connected to server")
	$Button_Class1.connect("pressed", self, "_on_button1_pressed")
	$Button_Class2.connect("pressed", self, "_on_button2_pressed")
	$Button_Class3.connect("pressed", self, "_on_button3_pressed")
	OS.set_window_fullscreen(true)
func _process(delta):
	if client.get_connection_status() == NetworkedMultiplayerENet.CONNECTION_CONNECTED:
		rpc("server_function", "hi")


func _write_info():
	fileSave.open("res://class.txt", File.WRITE)
	fileSave.store_string(info)
	fileSave.close()
	file.open("res://static/type_g.txt", File.READ)
	var t_g = file.get_as_text()
	file.close()
	if t_g == "1":
		get_tree().change_scene("res://object/main_sceen.tscn")
	if t_g == "2":
		get_tree().change_scene("res://game1x1/Game1x1.tscn")

		

func _on_button1_pressed():
	info = "paladin"
	_write_info()
func _on_button2_pressed():
	info = "shooter"
	_write_info()
func _on_button3_pressed():
	info = "wizard"
	_write_info()
remotesync func _update_state(state):
	# Обнови состояние объекта на клиенте
	print(state)
