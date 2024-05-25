extends Button


var client = StreamPeerTCP.new()
var mes = ""

func _ready():
	connect("pressed", self, "_on_button_pressed")
	var error = client.connect_to_host("127.0.0.1", 12345)
	if error == OK:
		print("Connected to server")
	else:
		print("Failed to connect to server")

func _on_button_pressed():
	text = "Поиск"
	if client.get_status() == StreamPeerTCP.STATUS_CONNECTED:
		if client.get_available_bytes() > 0:
			var data = client.get_utf8_string(client.get_available_bytes())
			var half_length = data.length() / 2
			var first_half = data.substr(0, half_length)
			data = data.substr(half_length, half_length)
			print("Received from server: ", data)
			print(data)
			get_parent().search = true
	else:
		print("Disconnected from server")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
