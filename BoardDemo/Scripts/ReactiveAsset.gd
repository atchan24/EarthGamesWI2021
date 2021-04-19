extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var done = false
signal finished_moving
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move_body():
	move_and_slide(Vector3(0, -1, 0).normalized() * 10)
	if (self.global_transform.origin.y <= 7):
		yield(get_tree().create_timer(1.0), "timeout")
		emit_signal("finished_moving")
		done = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (visible && !done):
		move_body()
