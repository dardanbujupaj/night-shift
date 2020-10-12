extends Node2D




# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	randomize()
	get_tree().set_group("enemies", "target", $Character)
	pass # Replace with function body.


func _unhandled_input(event):
		
	if OS.is_debug_build():
		if Input.is_key_pressed(KEY_R):
			get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ZombieTimer_timeout():
	for _i in randi() % 5:
		var zombie = preload("res://scenes/enemies/Zombie.tscn").instance()
		zombie.target = $Character
		zombie.position = $ZombieSpawn.position + Vector2(rand_range(-10, 10), rand_range(-10, 10))
		$YSort/enemies.add_child(zombie)
