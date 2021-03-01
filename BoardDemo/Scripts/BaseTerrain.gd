extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var hide_on_start : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func toggle_vis():
	self.visible = !self.visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
