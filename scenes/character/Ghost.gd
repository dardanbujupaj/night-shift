extends KinematicBody2D

var velocity = Vector2()

var target: Node2D = null
var target_point: Vector2

var knockback_velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	set_random_target_point()
	
	
	$Tween.interpolate_property($ghost, "position", Vector2(0, 0), Vector2(0, -5), 2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($ghost, "position", Vector2(0, -5), Vector2(0, 0), 2, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 2)
	$Tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	if OS.is_debug_build():
		draw_line(to_local(position), to_local(target_point), Color.white)
	
func _process(delta):
	if OS.is_debug_build():
		update()

func _physics_process(delta):
	if target != null:
		target_point = target.position
	elif position.distance_to(target_point) < 20:
		set_random_target_point()
		
		
	
	velocity += (target_point - position).normalized() * 30 * delta
	
	velocity = velocity.clamped(30)
	
	move_and_slide(velocity.clamped(30) + knockback_velocity)
	
	knockback_velocity *= 0.1


func hit(impact_velocity: Vector2) -> void:
	knockback_velocity = impact_velocity


func set_random_target_point():
	print("new random target")
	target_point = Vector2(rand_range(position.x - 100, position.x + 100), rand_range(position.y - 100, position.y + 100))
