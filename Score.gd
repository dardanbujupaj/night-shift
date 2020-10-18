extends Node


const HIGHSCORE_FILENAME = "highscore.json"


var wave = 0
var enemies_killed = 0
var burgers_shot = 0
var ingredients_collected = 0


var highscore = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("tree_exited", self, "save_highscore")
	connect("tree_entered", self, "load_highscore")


func reset():
	wave = 0
	enemies_killed = 0
	burgers_shot = 0
	ingredients_collected = 0
	


func get_highscore(type: String) -> int:
	if highscore.has(type):
		return highscore[type]
	else:
		return 0


func set_highscore(type: String, score: int) -> void:
	highscore[type] = score
	save_highscore()


func save_highscore() -> void:
	var file = File.new()
	file.open("user://" + HIGHSCORE_FILENAME, File.WRITE)
	file.store_line(to_json(highscore))
	file.close()
	

func load_highscore() -> void:
	var dir = Directory.new()
	
	if dir.file_exists("user://" + HIGHSCORE_FILENAME):
		var file = File.new()
		file.open("user://" + HIGHSCORE_FILENAME, File.READ)
		highscore = parse_json(file.get_line())
		file.close()


func reset_highscore() -> void:
	var dir = Directory.new()
	if dir.file_exists("user://" + HIGHSCORE_FILENAME):
		dir.remove("user://" + HIGHSCORE_FILENAME)
	highscore = {}
	

