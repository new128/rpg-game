extends Control


func _ready():
	pass



func _process(delta):
	var kin_bod = get_node("/root/Spatial/KinematicBody")
	$ProgressBar/hp.text = String(kin_bod.person.hp)
	$ProgressBar/max_hp.text = String(kin_bod.person.max_hp)
	$ProgressBar2/mana.text = String(kin_bod.person.mana)
	$ProgressBar2/max_mana.text = String(kin_bod.person.max_mana)
