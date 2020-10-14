extends KinematicBody2D


signal died

const JUMP_SPEED = 200
const GRAVITY = 200
const ACCELERATION = 500
const MAX_SPEED = 300
const DODGE_SPEED = 200

const WEAPON_KICKBACK = 300

var hitpoints = 10


var fire_rate = 3
var last_shot = 0

var dodge_direction: Vector2

var state = State.IDLE

enum State {
	IDLE,
	WALK,
	DODGE
}
enum Direction {
	LEFT = -1
	RIGHT = 1
}

var velocity = Vector2()
var knockback_velocity = Vector2()
var direction = Direction.RIGHT setget _set_direction


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	if Input.is_action_pressed("shoot"):
		shoot()

func _unhandled_input(event):
	
	if Input.is_action_just_pressed("dodge") and state == State.IDLE or state == State.WALK:
		dodge()
	


func _physics_process(delta):
	# if Input.is_action_just_pressed("jump"):
	# 	velocity.y = -JUMP_SPEED
	
	"""
	
	var acceleration = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left")) * ACCELERATION
	
	if acceleration != 0:
		if sign(acceleration) != direction:
			self.direction = sign(acceleration)
		
		if sign(acceleration) != sign(velocity.x):
			velocity.x += acceleration * 2 * delta
		else:
			velocity.x += acceleration * delta
	else:
		velocity.x *= 0.8
	
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	"""
	match state:
		State.IDLE, State.WALK:
			$AnimatedSprite.scale.x = sign(get_local_mouse_position().x)
			
			velocity.x = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
			velocity.y = (Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
			velocity = move_and_slide(velocity.normalized() * MAX_SPEED + knockback_velocity)
		State.DODGE:
			velocity = move_and_slide(dodge_direction * DODGE_SPEED)
	
	
	knockback_velocity *= delta * 10
	



func shoot():
	if (OS.get_ticks_msec() - last_shot) > 1000 / fire_rate:
		
		$ShootAudioStreamPlayer.play()
		
		var projectile = preload("res://scenes/character/burger/Burger.tscn").instance()
		projectile.position = position + Vector2(0, -12)
		projectile.direction = (get_local_mouse_position() + Vector2(0, 12)).normalized()
		projectile.speed = 150
		projectile.knockback = 400
		projectile.damage = 1
		get_parent().add_child(projectile)
		last_shot = OS.get_ticks_msec()
		Input.get_current_cursor_shape()
		
		knockback_velocity -= projectile.direction * WEAPON_KICKBACK


func dodge():
	state = State.DODGE
	dodge_direction = get_local_mouse_position().normalized()
	$AnimatedSprite.play("dodge")
	$DodgeAudioStreamPlayer.play()
	$CollisionShape2D.disabled = true

func hit(damage: int, impact_velocity: Vector2) -> void:
	hitpoints -= damage
	if hitpoints <= 0:
		die()
	knockback_velocity += impact_velocity
	$Camera2D.add_trauma(.3)
	
	$HitTween.interpolate_property(self, "modulate", Color.white, Color.white * 2, 0.1, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	$HitTween.interpolate_property(self, "modulate", Color.white * 2, Color.white, 0.1, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT, 0.1)
	$HitTween.start()
	
func die():
	emit_signal("died")
	

func _set_direction(new_direction):
	print(new_direction)
	$AnimatedSprite.scale.x = new_direction
	direction = new_direction


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "dodge":
		$AnimatedSprite.play("walk")
		state = State.IDLE
		$CollisionShape2D.disabled = false
