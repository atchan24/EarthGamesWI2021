extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var done = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move_body():
	move_and_slide(Vector3(0, -1, 0).normalized() * 10)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (visible):
		move_body()
