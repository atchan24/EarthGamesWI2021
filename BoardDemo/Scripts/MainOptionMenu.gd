extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (get_parent().get_node("MainButtons").visible == true):
		self.visible = false


func _on_return_pressed():
	get_parent().get_node("MainButtons").visible = true
	self.visible = false


func _on_CreditsReturn_pressed():
	get_parent().get_node("Credits").visible = false
	get_parent().get_node("MainButtons").visible = true


func _on_credits_pressed():
	get_parent().get_node("Credits").visible = true
	get_parent().get_node("MainButtons").visible = false
