extends Control


onready var movement_box = get_node("ColorRect/VBoxContainer/VolumeSlider/move_cost")

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.movement_cost = movement_box.text

func _on_return_pressed():
	get_parent().get_node("PauseMenu").visible = true
	self.visible = false


func _on_move_cost_text_changed():
	Global.movement_cost = movement_box.text


func _on_options_pressed():
	self.visible = true
