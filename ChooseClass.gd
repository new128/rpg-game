extends Node2D

var fileSave = File.new()
var info = null

func _ready():
	$Button_Class1.connect("pressed", self, "_on_button1_pressed")
	$Button_Class2.connect("pressed", self, "_on_button2_pressed")
	$Button_Class3.connect("pressed", self, "_on_button3_pressed")
	OS.set_window_fullscreen(true)

func _write_info():
	fileSave.open("res://class.txt", File.WRITE)
	fileSave.store_string("Person.new(")
	for i in range(info.size()):
		fileSave.store_string(str(info[i]))
		if i != info.size()-1:
			fileSave.store_string(", ")
	fileSave.store_string(")")
	fileSave.close()
	get_tree().change_scene("res://object/main_sceen.tscn")

func _on_button1_pressed():
	info = [{"class" : "paladin", "pers_type" : "play_pers", "team" : "left"},
{"max_hp" : 1000, "hp": 1000, "max_mana": 200, "mana": 200, "regen_hp": 5, "regen_mana" : 1, "armor":10, "magic_damage_resist" : 30, "damage": 80, "attack_speed" : 2, "attack_radius" : 2.5, "speed" : 6,"max_skills" : 3, "lvl" : 1, "xp" : 0, "time" : 0},
null, Inventory.new({"head" : null, "shoulders" : null, "left_hand" : null, "right_hand" : null, "body" : null, "legs" : null}, [0,0,0]),500]
	_write_info()
func _on_button2_pressed():
	info = [{"class" : "shooter", "pers_type" : "play_pers", "team" : "left"},
{"max_hp" : 600, "hp": 600, "max_mana": 500, "mana": 500, "regen_hp": 4, "regen_mana" : 4, "armor":2, "magic_damage_resist" : 15, "damage": 75, "attack_speed" : 1.5, "attack_radius" : 7.5, "speed" : 9,"max_skills" : 4, "lvl" : 1, "xp" : 0, "time" : 0},
null, Inventory.new({"head" : null, "shoulders" : null, "left_hand" : null, "right_hand" : null, "body" : null, "legs" : null}, [0,0,0]),700]
	_write_info()
func _on_button3_pressed():
	info = [{"class" : "wizard", "pers_type" : "play_pers", "team" : "left"},
{"max_hp" : 400, "hp": 400, "max_mana": 700, "mana": 700, "regen_hp": 5, "regen_mana" : 1, "armor":10, "magic_damage_resist" : 30, "damage": 80, "attack_speed" : 2, "attack_radius" : 2.5, "speed" : 6,"max_skills" : 3, "lvl" : 1, "xp" : 0, "time" : 0},
null, Inventory.new({"head" : null, "shoulders" : null, "left_hand" : null, "right_hand" : null, "body" : null, "legs" : null}, [0,0,0]),800]
	_write_info()
