extends Enemy


func _ready():
	pass

func die():
	$zombie.rotation = PI / 2
	.die()
