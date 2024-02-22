extends Control

var ac_d2 = true
var ac_d3 = true
var ac_d4 = true
var ac_d5 = true


func _ready():
	$AcceptDialog.popup()



func _process(delta):
	if get_node("/root/Spatial").has_node("KinematicBody"):
		var kin_bod = get_node("/root/Spatial/KinematicBody")
		$ProgressBar/hp.text = String(int(kin_bod.person.hp))
		$ProgressBar/max_hp.text = String(int(kin_bod.person.max_hp))
		$ProgressBar2/mana.text = String(int(kin_bod.person.mana))
		$ProgressBar2/max_mana.text = String(int(kin_bod.person.max_mana))
		$ProgressBar.max_value = kin_bod.person.max_hp
		$ProgressBar.value = kin_bod.person.hp
		$ProgressBar2.max_value = kin_bod.person.max_mana
		$ProgressBar2.value = kin_bod.person.mana
		$Money.text = String(int(kin_bod.person.money))
		
		
		$Damage.text = "damage: "+ String(kin_bod.person.damage)
		$Armor.text = "armor: "+ String(kin_bod.person.armor)
		$Speed.text = "speed: "+ String(kin_bod.person.speed)
		
		
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
