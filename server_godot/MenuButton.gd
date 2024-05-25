extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("pressed", self, "_on_exit_pressed")
	connect("pressed", self, "_on_settings_pressed")

func _on_exit_pressed():
	get_tree().change_scene("res://object/Menu.tscn")
func _on_settings_pressed():
	$Button.visible = not $Button.visible


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
