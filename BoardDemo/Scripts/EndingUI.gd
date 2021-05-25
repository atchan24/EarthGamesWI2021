extends Control

var first_click = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show():
	self.visible = true

func _on_Button_pressed():
	for i in range (1,5):
		get_node("Player" + str(i)).visible = false
	get_node("Sustainability").visible = true
	get_node("ButtonPlayer").visible = false
	get_node("ButtonEnd").visible = true
	get_node("PlayerBackground").visible = false
	get_node("AllBackground").visible = true

func _on_ButtonEnd_pressed():
	if first_click:
		get_node("Sustainability").visible = false
		get_node("Society").visible = true
		first_click = false
	else:
		get_tree().quit()
