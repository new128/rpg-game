extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var camera_path_str = get_node("Camera").get_path()
	print("Путь к камере (в виде строки):", camera_path_str)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
