extends Area2D


var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	position += velocity * delta
	
	



func _on_Bread_body_entered(body: Node):
	if body.is_in_group("enemies") and body.has_method("hit"):
		body.hit(velocity)
