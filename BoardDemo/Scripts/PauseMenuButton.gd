extends TextureButton


# Declare member variables here. Examples:
export var reference_path = ""
export var start_focused = false
var clicked = null


# Called when the node enters the scene tree for the first time.
func _ready():
	if (start_focused):
		grab_focus()
	clicked = get_parent().get_node("Click")
	connect("mouse_entered", self, "_on_Button_mouse_entered")
	connect("pressed", self, "_on_Button_Pressed")

func _on_Button_mouse_entered():
	grab_focus()
	
func _on_Button_Pressed():
	clicked.play()
	if (reference_path == ""):
		get_tree().quit()
	elif (reference_path == "options"):
		get_parent().get_parent().get_parent().get_node("PauseMenu").visible = false
		get_parent().get_parent().get_parent().get_node("OptionMenu").visible = true
	elif (reference_path == "resume"):
		pass
	else:
		get_tree().change_scene(reference_path)
		
