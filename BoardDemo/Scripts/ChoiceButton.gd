extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal mouse_click(choice)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if (event.is_pressed() && !event.is_echo()):
		emit_signal("mouse_click", self.text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
