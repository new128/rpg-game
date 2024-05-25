extends Node

var server = NetworkedMultiplayerENet.new()
var connected = []
func _ready():
	server.create_server(4242, 10)  # Порт и количество соединений
	get_tree().set_network_peer(server)
	rpc_config("update_state", MultiplayerAPI.RPC_MODE_REMOTESYNC)
	print("Server started on port 4242")
	get_tree().connect("network_peer_connected", self, "_on_peer_connected")
func update_state(state):
	rpc("_update_state", state)
	
func _on_peer_connected(id):
	connected.append([id])
	print(connected)
	update_state(1)


remote func server_function(data):
	$Label.text = data
