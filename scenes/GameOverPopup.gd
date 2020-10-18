extends PopupPanel

onready var score_panel = $VBoxContainer/Score

var score_dict = {
	"wave": "Wave",
	"enemies_killed": "Zombies eliminated",
	"burgers_shot": "Total Burgers",
	"ingredients_collected": "Total Ingredients",
}



func update_score():
	for child in score_panel.get_children():
		child.free()
	
	
	for key in score_dict.keys():
		var description = score_dict[key]
		var score = Score.get(key)
		var highscore = Score.get_highscore(key)
		
		if score > highscore:
			Score.set_highscore(key, score)
		
		var label = Label.new()
		label.align = Label.ALIGN_CENTER
		label.text = _get_score_text(description, score, highscore)
		score_panel.add_child(label)

func _get_score_text(type: String, score: int, highscore: int) -> String:
	return "%s: %d (Highscore: %d)" % [type, score, highscore]

func _on_Restart_pressed():
	get_tree().paused = false
	get_tree().call_deferred("reload_current_scene")


func _on_GameOverPopup_about_to_show():
	update_score()
