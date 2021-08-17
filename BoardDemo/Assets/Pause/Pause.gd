extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		get_node("PauseMenu").visible = true
		get_node("OptionMenu").visible = false

func _on_resume_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state

func _on_menu_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
