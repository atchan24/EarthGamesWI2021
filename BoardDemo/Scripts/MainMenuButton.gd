extends TextureButton


export var reference_path = ""
export var start_focused = false
var clicked = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if (start_focused):
		grab_focus()
	clicked = get_parent().get_parent().get_node("Click")
	connect("mouse_entered", self, "_on_Button_mouse_entered")
	connect("pressed", self, "_on_Button_Pressed")

func _on_Button_mouse_entered():
	grab_focus()
	
func _on_Button_Pressed():
	clicked.play()
	if (reference_path == ""):
		get_tree().quit()
	elif (reference_path == "resume"):
		pass
	elif (reference_path == "options"):
		get_parent().get_parent().get_node("OptionMenu").visible = true
		get_parent().get_parent().get_node("MainButtons").visible = false
	elif (reference_path == "credits"):
		#get_parent().get_parent().get_node("CreditsMenu").visible = true
		#get_parent().get_parent().get_node("MainButtons").visible = false
		pass
	else:
		get_node("/root/Global").goto_scene(reference_path)
		
