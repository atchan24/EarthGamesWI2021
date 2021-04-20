extends Control

var first_click = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show():
	self.visible = true
	get_node("Society").visible = false
	get_node("Sustainability").visible = false

func _on_Button_pressed():
	if first_click:
		for i in range (1,5):
			get_node("Player" + str(i)).visible = false
		get_node("Sustainability").visible = true
		get_node("Society").visible = true
		get_node("Button").text = "Quit Game"
		first_click = false
	else:
		get_tree().quit()
