extends Node2D


onready var character = $YSort/Character

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	randomize()
	get_tree().set_group("enemies", "target", character)
	pass # Replace with function body.


func _unhandled_input(event):
		
	if OS.is_debug_build():
		if Input.is_key_pressed(KEY_R):
			get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ZombieTimer_timeout():
	for _i in randi() % 4 + 2:
		var zombie = preload("res://scenes/enemies/Zombie.tscn").instance()
		zombie.target = character
		zombie.position = $ZombieSpawn.position + Vector2(rand_range(-10, 10), rand_range(-10, 10))
		$YSort/enemies.add_child(zombie)
	
	

var max_ingredients = 12

func _on_IngredientsTimer_timeout():
	if get_tree().get_nodes_in_group("ingredients").size() < max_ingredients:
		for i in range(3):
			var pos = Vector2(rand_range(-250, 250), rand_range(-80, 80))
			var ingredient = preload("res://scenes/character/burger/Ingredient.tscn").instance()
			ingredient.ingredient = IngredientDB.Ingredients.values()[randi() % IngredientDB.Ingredients.size()]
			ingredient.position = pos
			add_child(ingredient)


func _on_Menu_pressed():
	$CanvasLayer/PauseMenu.popup_centered_minsize()
	get_tree().set_input_as_handled()


func _on_Character_died():
	$CanvasLayer/GameOverPopup.popup_centered_minsize()
	get_tree().paused = true
