extends Node2D


onready var character = $YSort/Character
onready var powerup_popup = $CanvasLayer/PowerupPopup

onready var wave_nr = $CanvasLayer/PanelContainer/VBoxContainer/Wave
onready var eliminated = $CanvasLayer/PanelContainer/VBoxContainer/Eliminated

const POWERUP_DAMAGE = "Damage"
const POWERUP_FIRERATE = "Firerate"
const POWERUP_KNOCKBACK = "Knockback"



var wave = 1
var wave_enemies = 0
var wave_spawned = 0
var wave_killed = 0

var total_killed = 0
var total_burgers = 0
var total_ingredients_collected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	randomize()
	get_tree().set_group("enemies", "target", character)
	Score.reset()
	start_wave(wave)
	
	check_first_game()

# Check if the game is played for the first time
# If not, the game is paused, and the controls are shown...
func check_first_game():
	var dir = Directory.new()
	if not dir.file_exists("user://first_game"):
		get_tree().paused = true
		$CanvasLayer/HowtoPanel.popup_centered_minsize()
		
		var file = File.new()
		file.open("user://first_game", File.WRITE)
		file.close()

func _unhandled_input(event):
		
	if OS.is_debug_build():
		if Input.is_key_pressed(KEY_R):
			get_tree().reload_current_scene()


func update_wavecount():
	wave_nr.text = "Wave %d" % wave
	eliminated.text = "%d/%d eliminated" % [wave_killed, wave_enemies]

func start_wave(wave_nr: int):
	$ZombieTimer.start()
	wave_enemies = pow(wave_nr, 2) + randi() % 2
	wave_spawned = 0
	wave_killed = 0
	
	update_wavecount()


func _on_zombie_died():
	wave_killed += 1
	Score.enemies_killed += 1
	update_wavecount()
	check_wave()


func check_wave():
	if wave_killed >= wave_enemies:
		_on_wave_defeated()



func _on_ZombieTimer_timeout():
	for _i in randi() % 6 + 2:
		if wave_spawned < wave_enemies:
			var zombie = preload("res://scenes/enemies/Zombie.tscn").instance()
			zombie.target = character
			zombie.hitpoints = 4 + wave * 2
			zombie.speed = 100 + 10 * wave
			zombie.position = $ZombieSpawn.position + Vector2(rand_range(-10, 10), rand_range(-10, 10))
			zombie.connect("died", self, "_on_zombie_died")
			wave_spawned += 1
			$YSort/enemies.add_child(zombie)
	
	

var max_ingredients = 20

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


# after a wave is defeated the game is paused and a powerup is available
func _on_wave_defeated():
	# pause game
	get_tree().paused = true
	
	# show available powerups
	var powerups = [
		{
			"type": POWERUP_DAMAGE,
			"amount": randi() % 3 + 1
		},
		{
			"type": POWERUP_FIRERATE,
			"amount": randi() % 3 + 1
		},
		{
			"type": POWERUP_KNOCKBACK,
			"amount": randi() % 3 + 1
		},
	]
	powerup_popup.powerups = powerups
	powerup_popup.popup_centered_minsize()
	
	# wait for selection of powerup
	yield(powerup_popup, "powerup_selected")
	
	get_tree().paused = false
	
	Score.wave = wave
	
	wave += 1
	start_wave(wave)


func _on_PowerupPopup_powerup_selected(type, amount):
	match type:
		POWERUP_DAMAGE:
			character.attack_damage += amount
		POWERUP_FIRERATE:
			character.firerate += amount
		POWERUP_KNOCKBACK:
			character.weapon_knockback += amount
		
		


func _on_HowtoPanel_popup_hide():
	get_tree().paused = false
