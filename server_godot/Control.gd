extends Control

var ac_d2 = true
var ac_d3 = true
var ac_d4 = true
var ac_d5 = true

var notice = false

var time = 0

signal button_Z_pressed
signal button_X_pressed
signal button_C_pressed
signal button_Q_pressed
signal button_W_pressed
signal button_E_pressed
signal button_D_pressed
signal button_F_pressed
signal button_R_pressed
signal button_buy_falakaxa_pressed
signal button_buy_pigeon_pressed
signal button_buy_weapon


func _ready():

	
	
	
	OS.set_window_fullscreen(true)
	rect_min_size = OS.get_window_size()
	rect_position = Vector2(0, 0)
	
	
	
	$consumable1.connect("pressed", self, "_on_button_Z_pressed")
	$consumable2.connect("pressed", self, "_on_button_X_pressed")
	$consumable3.connect("pressed", self, "_on_button_C_pressed")
	$Skill1.connect("pressed", self, "_on_button_Q_pressed")
	$Skill2.connect("pressed", self, "_on_button_W_pressed")
	$Skill3.connect("pressed", self, "_on_button_E_pressed")
	$Skill4.connect("pressed", self, "_on_button_D_pressed")
	$Skill5.connect("pressed", self, "_on_button_T_pressed")
	$Skill5.connect("pressed", self, "_on_button_R_pressed")
	$Shop/falakaxa.connect("pressed", self, "_on_button_buy_falakaxa_pressed")
	$Shop/pigeon.connect("pressed", self, "_on_button_buy_pigeon_pressed")
	$Shop/sword_is_rusty.connect("pressed", self, "_on_button_buy_sword_is_rusty")
	$Shop/wooden_bow.connect("pressed", self, "_on_button_buy_wooden_bow")
	$Shop/regular_staff.connect("pressed", self, "_on_button_buy_regular_staff")
	$Shop/steel_sword.connect("pressed", self, "_on_button_buy_steel_sword")
	$Shop/slicing_bow.connect("pressed", self, "_on_button_buy_slicing_bow")
	
	
	#$AcceptDialog.popup()



func _process(delta):
	
	
	if notice:
		time+=delta
		if time >= 3: 
			notice = false
			time = 0
	else:
		$Notice.visible = false

	if get_node("/root/Spatial").has_node("KinematicBody"):
		var kin_bod = get_node("/root/Spatial/KinematicBody")
		$ProgressBar/hp.text = String(int(kin_bod.person.person_stats["hp"]))
		$ProgressBar/max_hp.text = String(int(kin_bod.person.person_stats["max_hp"]))
		$ProgressBar/regen_hp.text = String(int(kin_bod.person.person_stats["regen_hp"]))
		$ProgressBar2/mana.text = String(int(kin_bod.person.person_stats["mana"]))
		$ProgressBar2/max_mana.text = String(int(kin_bod.person.person_stats["max_mana"]))
		$ProgressBar2/regen_mana.text = String(int(kin_bod.person.person_stats["regen_mana"]))
		$ProgressBar.max_value = kin_bod.person.person_stats["max_hp"]
		$ProgressBar.value = kin_bod.person.person_stats["hp"]
		$ProgressBar2.max_value = kin_bod.person.person_stats["max_mana"]
		$ProgressBar2.value = kin_bod.person.person_stats["mana"]
		$Money.text = String(int(kin_bod.person.money))
		$Damage.text = "damage: "+ String(kin_bod.person.person_stats["damage"])
		$Armor.text = "armor: "+ String(kin_bod.person.person_stats["armor"])
		$Speed.text = "speed: "+ String(kin_bod.person.person_stats["speed"])
		$Lvl.text = "lvl: "+ String(kin_bod.person.person_stats["lvl"])
		$Xp.text = "xp: "+ String(kin_bod.person.person_stats["xp"])
	
	if not $AcceptDialog.visible and ac_d2:
		$AcceptDialog2.popup()
		ac_d2 =false
	if not $AcceptDialog2.visible and ac_d3 and not ac_d2:
		$AcceptDialog3.popup()
		ac_d3 =false
	if not $AcceptDialog3.visible and not ac_d3 and not ac_d2 and ac_d4:
		$AcceptDialog4.popup()
		ac_d4 =false
	if not $AcceptDialog4.visible and not ac_d3 and not ac_d2 and not ac_d4 and ac_d5:
		$AcceptDialog5.popup()
		ac_d5 =false

func _input(event):
	if event is InputEventKey and event.pressed and Input.is_action_pressed("f4"):
		$Shop.visible = not $Shop.visible 




func change_notice(text):
	$Notice/Label.text = text
	$Notice.visible = true
	notice = true

func _on_button_Z_pressed():
	# Излучаем сигнал при нажатии кнопки
	$Shop.visible = not $Shop.visible 
	print("ZZZZZZZZZZZZZZZZZZZZZZZZZ")
	emit_signal("button_Z_pressed")
func _on_button_X_pressed():
	# Излучаем сигнал при нажатии кнопки
	$Shop.visible = not $Shop.visible 
	print("XXXXXXXXXXXXXXXXXXXXXXXXXX")
	emit_signal("button_X_pressed")
func _on_button_C_pressed():
	# Излучаем сигнал при нажатии кнопки
	$Shop.visible = not $Shop.visible 
	print("CCCCCCCCCCCCCCCCCCCCCCCCCCCC")
	emit_signal("button_C_pressed")
	
	
func _on_button_Q_pressed():
	emit_signal("button_Q_pressed")
func _on_button_W_pressed():
	emit_signal("button_W_pressed")
func _on_button_E_pressed():
	emit_signal("button_E_pressed")
func _on_button_D_pressed():
	emit_signal("button_D_pressed")
func _on_button_F_pressed():
	emit_signal("button_F_pressed")
func _on_button_R_pressed():
	emit_signal("button_R_pressed")
	

	
func _on_button_buy_falakaxa_pressed():
	emit_signal("button_buy_falakaxa_pressed")
func _on_button_buy_pigeon_pressed():
	emit_signal("button_buy_pigeon_pressed")
	

func _on_button_buy_sword_is_rusty():
	emit_signal("button_buy_weapon", "sword_is_rusty")

func _on_button_buy_wooden_bow():
	emit_signal("button_buy_weapon", "wooden_bow")

func _on_button_buy_regular_staff():
	emit_signal("button_buy_weapon", "regular_staff")
func _on_button_buy_steel_sword():
	emit_signal("button_buy_weapon", "steel_sword")
func _on_button_buy_slicing_bow():
	emit_signal("button_buy_weapon", "slicing_bow")
