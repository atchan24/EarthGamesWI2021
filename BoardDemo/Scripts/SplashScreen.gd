extends Node2D

### SPLASH SCREEN
# flash logos and then go to main menu when the animation player is done.

var _d
var destination : String = "res://Scenes/MainMenu.tscn"



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Splash":
		_d = get_node("/root/Global").goto_scene(destination)

