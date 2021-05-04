extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state


func _on_resumeButton_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state


func _on_menuButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	# var new_pause_state = not get_tree().paused
	# get_tree().paused = new_pause_state
	# visible = new_pause_state
	

