extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
var target = null
var target_position = null
var self_ = null

var damage = null

var sceen = null

var pers = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if target != null:
		target_position = target.global_transform.origin
	else:
		self.queue_free()
	pers = sceen.all_person.duplicate()
	pers.erase(target)

func _process(delta):
	
	
	
	if target != null and is_instance_valid(target):
		
		
		target_position = target.global_transform.origin
		var direction = (target_position - translation).normalized()
		direction.y = 0
		if direction.length() > 0.1:
			var angle = atan2(direction.x, direction.z)
			rotation_degrees.y = angle * 180 / PI
		global_translate(direction * 40 * delta)
		for it in pers:
			if it:
				if it.person.person_const["team"] != self_.person.person_const["team"]:
					
					var dist_ = sqrt((translation.x-it.translation.x)*(translation.x-it.translation.x)+(translation.z-it.translation.z)*(translation.z-it.translation.z))
					if dist_ <= 3:
						it.person.taking_damage("mag", damage)
						it.last_attack = self_.person
						pers.erase(it)
				
				
		var dist = sqrt((translation.x-target.translation.x)*(translation.x-target.translation.x)+(translation.z-target.translation.z)*(translation.z-target.translation.z))
		if dist <= 1.5:
			target.person.taking_damage("mag", damage)
			self.queue_free()
			target.last_attack = self_.person
		
	else:
		self.queue_free()
	

