extends Enemy


func _ready():
	hitpoints = 5
	speed = 80

func die():
	$zombie.rotation = PI / 2
	.die()
