extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var x_speed : float
export var interval : float

var time_left
var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	time_left = interval
	sprite = get_node("Sprite3D")

func _fixed_process(delta):
	if x_speed != 0:
		move(delta)
	
func move(delta):
	time_left = time_left - delta
	if time_left <= 0:
		time_left = interval
		x_speed = x_speed * -1
	move_and_slide(Vector3(1, 0, 0) * x_speed)
	sprite.set_flip_h(x_speed > 0)
