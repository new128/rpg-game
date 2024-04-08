extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
var target = null
var target_position = null



# Called when the node enters the scene tree for the first time.
func _ready():
	if target != null:
		target_position = target.global_transform.origin
	else:
		self.queue_free()

func _process(delta):
	if target != null and is_instance_valid(target):
		target_position = target.global_transform.origin
		var direction = (target_position - translation).normalized()
		direction.y = 0
		if direction.length() > 0.1:
			var angle = atan2(direction.x, direction.z)
			rotation_degrees.y = angle * 180 / PI
		move_and_slide(direction * 1)
	else:
		self.queue_free()

