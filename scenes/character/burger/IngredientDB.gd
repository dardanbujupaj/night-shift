tool
extends Node

enum Ingredients {
	KETCHUP,
	MAYO,
	MUSTARD,
	PATTY,
	SALAD,
	CHEESE,
	TOMATOES,
	PICKLES
}

var ingredient_data = {
	Ingredients.KETCHUP: {
		"height": 1,
		"offset": -3,
		"color": Color(1, 0, 0),
		"texture": preload("res://scenes/character/burger/burger_ketchup.png")
	},
	Ingredients.MAYO: {
		"height": 1,
		"offset": -3,
		"color": Color(0.965942, 1, 0.859375),
		"texture": preload("res://scenes/character/burger/burger_mayo.png")
	},
	Ingredients.MUSTARD: {
		"height": 1,
		"offset": -3,
		"color": Color(0.886475, 1, 0.53125),
		"texture": preload("res://scenes/character/burger/burger_mustard.png")
	},
	Ingredients.SALAD: {
		"height": 2,
		"offset": 1,
		"color": Color(0, 0.703125, 0.175781),
		"texture": preload("res://scenes/character/burger/burger_salad.png")
	},
	Ingredients.PATTY: {
		"height": 2,
		"offset": -2,
		"color": Color(0.355469, 0.173569, 0.173569),
		"texture": preload("res://scenes/character/burger/burger_patty.png")
	},
	Ingredients.TOMATOES: {
		"height": 1,
		"offset": 3,
		"color": Color(0.746094, 0.145721, 0.145721),
		"texture": preload("res://scenes/character/burger/burger_tomatoes.png")
	},
	Ingredients.PICKLES: {
		"height": 1,
		"offset": 4,
		"color": Color(0.018158, 0.332031, 0),
		"texture": preload("res://scenes/character/burger/burger_pickles.png")
	},
	Ingredients.CHEESE: {
		"height": 1,
		"offset": 0,
		"color": Color(0.736328, 1, 0.15625),
		"texture": preload("res://scenes/character/burger/burger_cheese.png")
	},
	
}
