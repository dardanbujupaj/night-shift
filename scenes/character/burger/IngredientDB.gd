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
		"texture": preload("res://scenes/character/burger/burger_ketchup.png")
	},
	Ingredients.MAYO: {
		"height": 1,
		"offset": -3,
		"texture": preload("res://scenes/character/burger/burger_mayo.png")
	},
	Ingredients.MUSTARD: {
		"height": 1,
		"offset": -3,
		"texture": preload("res://scenes/character/burger/burger_mustard.png")
	},
	Ingredients.SALAD: {
		"height": 2,
		"offset": 1,
		"texture": preload("res://scenes/character/burger/burger_salad.png")
	},
	Ingredients.PATTY: {
		"height": 2,
		"offset": -2,
		"texture": preload("res://scenes/character/burger/burger_patty.png")
	},
	Ingredients.TOMATOES: {
		"height": 1,
		"offset": 3,
		"texture": preload("res://scenes/character/burger/burger_tomatoes.png")
	},
	Ingredients.PICKLES: {
		"height": 1,
		"offset": 4,
		"texture": preload("res://scenes/character/burger/burger_pickles.png")
	},
	Ingredients.CHEESE: {
		"height": 1,
		"offset": 0,
		"texture": preload("res://scenes/character/burger/burger_cheese.png")
	},
	
}
