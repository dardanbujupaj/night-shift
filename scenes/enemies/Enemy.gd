extends KinematicBody2D
class_name Enemy

signal died

var draw_target = false

var speed = 100 # movement rate of the enemy
var knockback = 1000 # knockback of the attack
var damage = 1 # damage per attack
var attack_range = 20 # distance in which the enemy can attack
var attack_rate = 1 # number of times the enemy can attack per second

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
	if draw_target:
		draw_line(to_local(position), to_local(target_point), Color.white)


func _process(delta):
	if draw_target:
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
	
	if OS.get_ticks_msec() - last_hit > 1000 / attack_rate:
		attack()


func attack():
	var collider = attack_ray.get_collider()
	if collider != null:
		var direction = (collider.position - position).normalized()
		collider.hit(damage, direction * knockback)
		last_hit = OS.get_ticks_msec()


# is called when the enemy gets hit
func hit(damage_taken: int, impact_velocity: Vector2) -> void:
	hitpoints -= damage_taken
	if hitpoints <= 0 and not dead:
		die()
		return
	knockback_velocity = impact_velocity
	
	$HitTween.interpolate_property(self, "modulate", Color.white, Color.white * 10, 0.1, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	$HitTween.interpolate_property(self, "modulate", Color.white * 10, Color.white, 0.1, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT, 0.1)
	$HitTween.start()


# is called when the enemies hitpoints drop to zero
func die():
	
	dead = true
	modulate = Color.white * 2
	z_index = -1
	remove_from_group("enemies")
	emit_signal("died")
	$CollisionShape2D.set_deferred("disabled", true)
	$HitTween.stop_all()


func set_random_target_point():
	target_point = Vector2(rand_range(position.x - 100, position.x + 100), rand_range(position.y - 100, position.y + 100))
