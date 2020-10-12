extends Area2D



var current_height = 0

var velocity = Vector2()
var angular_velocity: float

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for _i in range(randi() % 5):
		var ingredient = randi() % IngredientDB.Ingredients.size()
		add_ingredient(ingredient)
	rotation = randf() * 2 * PI
	angular_velocity = rand_range(-PI, PI)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(angular_velocity * delta)


func _physics_process(delta):
	position += velocity * delta
	
# Add a Ingredients to the Burger
# see Ingredients-enum
func add_ingredient(ingredient):
	var data = IngredientDB.ingredient_data[ingredient]
	
	#add Ingredients
	var sprite = Sprite.new()
	sprite.texture = data["texture"]
	sprite.offset.y = data["offset"] - current_height
	current_height += data["height"]
	add_child(sprite)
	
	#mover upper bun
	$burger_upper.offset.y = 5 - current_height



func _on_Bread_body_entered(body: Node):
	if body.is_in_group("enemies") and body.has_method("hit"):
		body.hit(1, velocity)


func _on_Bread_area_entered(area):
	if area.get("ingredient") != null:
		add_ingredient(area.ingredient)
		area.queue_free()
	pass # Replace with function body.
