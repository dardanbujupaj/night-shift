extends Node2D


export(float) var radius = 10.0
export(float) var damage = 5



# Called when the node enters the scene tree for the first time.
func _ready():
	var circle = CircleShape2D.new()
	circle.radius = radius
	$CollisionShape2D.shape = circle



func _draw():
	var color = Color.black if $TimerBlack.time_left > 0 else Color.white
	draw_circle(Vector2(), radius, color)


func _on_TimerBlack_timeout():
	$TimerWhite.start()
	update()


func _on_TimerWhite_timeout():
	queue_free()


func _on_Explosion_body_entered(body):
	print("hit " + str(body))
	body.hit(damage, (body.position - position).normalized() * 100 * damage)
	
