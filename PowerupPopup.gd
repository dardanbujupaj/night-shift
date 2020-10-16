extends PopupPanel

signal powerup_selected

onready var powerup_container = $VBoxContainer/HBoxContainer

var powerups: Array


func prepare_powerups():
	for child in powerup_container.get_children():
		child.queue_free()
	
	for powerup in powerups:
		var button = Button.new()
		button.text = "{type} +{amount}".format(powerup)
		button.connect("pressed", self, "emit_signal", 
			["powerup_selected", powerup["type"], powerup["amount"]])
		button.connect("pressed", self, "hide")
		powerup_container.add_child(button)


func _on_PowerupPopup_about_to_show():
	prepare_powerups()
