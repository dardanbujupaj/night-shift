extends PopupPanel



func _on_Resume_pressed():
	hide()


func _on_Titlescreen_pressed():
	$CanvasLayer/HowtoPanel.popup_centered_minsize()


func _on_Quit_pressed():
	get_tree().quit()


func _on_PauseMenu_about_to_show():
	get_tree().paused = true


func _on_PauseMenu_popup_hide():
	get_tree().paused = false
