extends Control


func _ready():
	pass



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
