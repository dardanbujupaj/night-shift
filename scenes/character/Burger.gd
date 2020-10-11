extends Area2D


var velocity = Vector2()
var angular_velocity: float

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	rotation = randf() * 2 * PI
	angular_velocity = rand_range(-PI, PI)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(angular_velocity * delta)


func _physics_process(delta):
	position += velocity * delta
	
	



func _on_Bread_body_entered(body: Node):
	if body.is_in_group("enemies") and body.has_method("hit"):
		body.hit(1, velocity)
