extends KinematicBody2D
class_name Enemy

var speed = 100
var knockback = 300
var damage = 1
var attack_range = 20

var velocity = Vector2()
var knockback_velocity = Vector2()

var hitpoints: int

var dead: bool

var target: Node2D = null
var target_point: Vector2

var last_hit = 0

onready var attack_ray: RayCast2D = $AttackRay

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	set_random_target_point()


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
	if dead:
		return
		
	
	if target != null:
		target_point = target.position
	elif position.distance_to(target_point) < 20:
		set_random_target_point()
		
		
	
	velocity += (target_point - position).normalized() * speed * delta
	
	velocity = velocity.clamped(speed)
	
	$AttackRay.cast_to = (target_point - position).normalized() * attack_range
	
	move_and_slide(velocity + knockback_velocity)
	
	knockback_velocity *= delta
	
	if OS.get_ticks_msec() - last_hit > 1000:
		attack()


func attack():
	var collider = attack_ray.get_collider()
	if collider != null:
		print("attack hit")
		var direction = (collider.position - position).normalized()
		collider.hit(damage, direction * knockback)
		last_hit = OS.get_ticks_msec()

func hit(damage_taken: int, impact_velocity: Vector2) -> void:
	hitpoints -= damage_taken
	if hitpoints <= 0:
		die()
	knockback_velocity = impact_velocity


func die():
	dead = true
	$CollisionShape2D.set_deferred("disabled", true)


func set_random_target_point():
	print("new random target")
	target_point = Vector2(rand_range(position.x - 100, position.x + 100), rand_range(position.y - 100, position.y + 100))
