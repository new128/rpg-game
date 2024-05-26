extends Spatial


var crips_and_towers = [] # Объекты которые должны бить
var time = 0
var all_person = []
var Person = preload("res://person.gd")
var crip = null
var el_t = null
var back_el_t = 0
var end_game = false
var loser = null
var vision_left = []
var vision_right = []
var server = NetworkedMultiplayerENet.new()
var connected = []
var CRIP = null



func _ready():
	server.create_server(4242, 10)  # Порт и количество соединений
	get_tree().set_network_peer(server)
	rpc_config("update_state", MultiplayerAPI.RPC_MODE_REMOTESYNC)
	print("Server started on port 4242")
	
	
	get_tree().connect("network_peer_connected", self, "_on_peer_connected")
	Engine.set_target_fps(60)
	CRIP = $Crip
	var file = File.new()
	var file_path = "user://win.txt"
	if file.open(file_path, File.WRITE) == OK:
		var text_to_write = "win"
		file.store_string(text_to_write)
		file.close()
		print("Текст успешно записан в файл.")
	
	
	vision_left.append($LT1)
	vision_left.append($RT1)
	vision_left.append($KinematicBody)
	
	
	crip = $Crip
	vision_right.append(crip)
	crips_and_towers.append($LT1)
	crips_and_towers.append($RT1)
	#crips_and_towers.append($Enemy)
	crips_and_towers.append(crip)
	all_person.append($KinematicBody)
	all_person.append($Enemy)
	all_person.append($LT1)
	all_person.append($RT1)
	all_person.append(crip)
	
	for i in range(3):
		var new_crip = crip.duplicate()
		add_child(new_crip)
		vision_right.append(new_crip)
		crips_and_towers.append(new_crip)
		all_person.append(new_crip)
		new_crip.person.person_const["team"] = "right"
		new_crip.translation = Vector3(30+5*(i+1), 1.47, 60-5*(i+1))
	for j in range(4):
		var new_crip = crip.duplicate()
		add_child(new_crip)
		vision_left.append(new_crip)
		crips_and_towers.append(new_crip)
		all_person.append(new_crip)
		new_crip.person.person_const["team"] = "left"
		new_crip.translation = Vector3(-20-5*(j+1), 1.47, -70+5*(j+1))
	var el_t = int($Control/Time.elapsed_time)
	var back_el_t = el_t

func _process(delta):
	print(all_person)
	for it in all_person:
		if not is_instance_valid(it):
			all_person.erase(it)
			crips_and_towers.erase(it)
	var data = []
	for it in all_person:
		data.append([it.translation.x,it.translation.z,it.person.person_stats["hp"],it.person.person_stats["mana"],it.person.person_const["team"],len(all_person)])
	print(all_person)
	_u_s(data)
	
	while server.get_connection_status() == NetworkedMultiplayerENet.CONNECTION_CONNECTING:
		var peer_id = server.get_packet_peer()
		var packet = server.get_packet()
		handle_packet(packet, peer_id)
	
	
	
	for item in all_person:
		if is_instance_valid(item):
			if item.person.is_die:
				if item.person.person_const["pers_type"] == "play_pers" or item.person.person_const["pers_type"] == "enemy" or item.person.person_const["pers_type"] == "tower_friend":
					var file = File.new()
					var file_path = "user://win.txt"
					if file.open(file_path, File.WRITE) == OK:
						var text_to_write = item.person.person_const["team"]
						file.store_string(text_to_write)
						file.close()
						print("Текст успешно записан в файл.")
					end_game = true
				item.queue_free()
				if item in crips_and_towers: crips_and_towers.erase(item)
				if item in all_person: all_person.erase(item)
				if item in vision_left: vision_left.erase(item)
				if item in vision_right: vision_right.erase(item)
				all_person.erase(item)
		
	
	if end_game:
		get_tree().change_scene("res://object/Game_end.tscn")
		
	
	
	
	for item in all_person:
		for enemy in all_person:
			if is_instance_valid(item) and is_instance_valid(enemy):
				if item.person.person_const["team"] != enemy.person.person_const["team"]:
					var obj1_position = Vector2(item.global_transform.origin.x, item.global_transform.origin.z)
					var obj2_position = Vector2(enemy.global_transform.origin.x, enemy.global_transform.origin.z)
					var dist = obj1_position.distance_to(obj2_position)
					if dist <= 5:
						if item.person.person_const["team"] == "left":
							if not enemy in vision_left:
								vision_left.append(enemy)
						if item.person.person_const["team"] == "right":
							if not enemy in vision_right:
								vision_right.append(enemy)
	
	for en in vision_left:
		if is_instance_valid(en):
			var co = 0
			for it in all_person:
				if is_instance_valid(it):
					if it.person.person_const["team"] != en.person.person_const["team"]:
						var obj1_position = Vector2(it.global_transform.origin.x, it.global_transform.origin.z)
						var obj2_position = Vector2(en.global_transform.origin.x, en.global_transform.origin.z)
						var dist = obj1_position.distance_to(obj2_position)
						if dist <= 5:
							co+=1
			if co == 0 and not(en.person.person_const["team"] == "left") and not en.name == "RT1":
				vision_left.erase(en)
				if is_instance_valid(en):pass
					#en.visible = false
					#en.get_node("HUD").visible = false
	
	for vis in vision_left:
		if is_instance_valid(vis):pass
			#vis.visible = true
			#vis.get_node("HUD").visible = true
	
	
	
	
	el_t = int($Control/Time.elapsed_time)
	if el_t % 60 == 0 and el_t - back_el_t > 1:
		for i in range(4):
			var new_crip = crips_and_towers[3].duplicate()
			add_child(new_crip)
			vision_right.append(new_crip)
			crips_and_towers.append(new_crip)
			all_person.append(new_crip)
			new_crip.person.person_const["team"] = "right"
			new_crip.translation = Vector3(30+5*(i+1), 1.47, 60-5*(i+1))
		for j in range(4):
			var new_crip = crips_and_towers[3].duplicate()
			add_child(new_crip)
			vision_left.append(new_crip)
			crips_and_towers.append(new_crip)
			all_person.append(new_crip)
			new_crip.person.person_const["team"] = "left"
			new_crip.translation = Vector3(-20-5*(j+1), 1.47, -70+5*(j+1))
		
		back_el_t = el_t
	
	for item in crips_and_towers:
		if is_instance_valid(item):
			var min_dist = INF
			var object_d = null
			if item.person.is_die() and item.person.person_const["team"] == "right" and item.person.person_const["class"] == "crip":
				$KinematicBody.person.money += 50
				$KinematicBody.person.person_stats["xp"] += 100
			if item.person.is_die() and item.person.person_const["team"] == "left" and item.person.person_const["class"] == "crip":
				$Enemy.person.money += 50
				$Enemy.person.person_stats["xp"] += 100
			elif item.person.is_die() and item.person.person_const["team"] == "right" and item.person.person_const["class"] == "tower":
				all_person[0].person.money += 500
				all_person[0].person.person_stats["xp"] += 1000
			for it in all_person:
				if is_instance_valid(it):
					if it != item and item.person.person_const["team"] != it.person.person_const["team"]:
						var dist = item.global_transform.origin.distance_to(it.global_transform.origin)
						if dist <= min_dist:
							min_dist = dist
							object_d = it
			if object_d != null:
				item.person.target["target"] = object_d.global_transform.origin
				item.person.target["target_person"] = object_d
	
	time += 1
	if time % 60 == 1 and get_node("/root/Spatial").has_node("KinematicBody"):
		$KinematicBody.person.money += 1.5
		
	
	
func handle_packet(packet, peer_id):
	# Обработай полученные данные от клиентов
	print("Received packet from peer ", peer_id)
	
func update_state(state):
	rpc("_update_state", state)
	
func _u_s(state):
	update_state(state)
	
	
func team(t):
	rpc("_team",t)
func _on_peer_connected(id):
	connected.append(id)
	#print(connected)
	team("left")
remote func server_function(data):pass
	#print("Received data from client: ", data)
remote func _start(data):
	var to_remove = []

	for it in all_person:
		print(it)
		print(it.person.person_const["class"])
		if it.person.person_const["class"] == "crip":
			to_remove.append(it)

	for it in to_remove:
		it.queue_free()
		all_person.erase(it)
		crips_and_towers.erase(it)

	print(all_person)
	add_child(CRIP)
	vision_right.append(CRIP)
	#crips_and_towers.append($LT1)
	#crips_and_towers.append($RT1)
	#crips_and_towers.append($Enemy)
	crips_and_towers.append(CRIP)
	#all_person.append($KinematicBody)
	#all_person.append($Enemy)
	#all_person.append($LT1)
	#all_person.append($RT1)
	all_person.append(CRIP)
	
	for i in range(3):
		var new_crip = CRIP.duplicate()
		add_child(new_crip)
		vision_right.append(new_crip)
		crips_and_towers.append(new_crip)
		all_person.append(new_crip)
		new_crip.person.person_const["team"] = "right"
		new_crip.translation = Vector3(30+5*(i+1), 1.47, 60-5*(i+1))
	for j in range(4):
		var new_crip = CRIP.duplicate()
		add_child(new_crip)
		vision_left.append(new_crip)
		crips_and_towers.append(new_crip)
		all_person.append(new_crip)
		new_crip.person.person_const["team"] = "left"
		new_crip.translation = Vector3(-20-5*(j+1), 1.47, -70+5*(j+1))
	var el_t = int($Control/Time.elapsed_time)
	var back_el_t = el_t
	$Control/Time.elapsed_time = 0
	for it in all_person:
		if not is_instance_valid(it):
			all_person.erase(it)
		
remote func _class(t, c):
	if t == "left":
		$KinematicBody.person = Person.new(c)
	if t == "right":
		$Enemy.person = Person.new(c)
remote func _pers_target(target, person_id):
	$KinematicBody.person.target["target"] = target
	$KinematicBody.is_move = true
	if person_id != -1:
		$KinematicBody.person.target["target_person"] = all_person[person_id]
		if $KinematicBody.person.attack($KinematicBody, $KinematicBody.person.target["target_person"], "simple", self):
			$KinematicBody.is_move = true
		#print(all_person[person_id], person_id)
	else:$KinematicBody.person.target["target_person"] = null
	
	#print("/n",all_person,"/n")
	
	#print($KinematicBody.person.target["target_person"])
	