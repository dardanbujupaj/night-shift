tool
extends Area2D
class_name Ingredient

export(IngredientDB.Ingredients) var ingredient setget _set_ingredient

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_set_ingredient(ingredient)
	pass # Replace with function body.

func _set_ingredient(new_ingredient):
	ingredient = new_ingredient
	if has_node("Sprite"):
		var data = IngredientDB.ingredient_data[new_ingredient]
		$Sprite.texture = data["texture"]
		$Sprite.offset.y = data["offset"]
