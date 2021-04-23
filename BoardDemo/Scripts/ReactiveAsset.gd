extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var done = false
export var height = 0
signal finished_moving
var sprite = null
var rot_speed = null

# Called when the node enters the scene tree for the first time.
func _ready():
	#print("This asset is getting ready to appear")
	#sprite = get_node("Sprite3D")
	pass # Replace with function body.

func move_body():
	#set_rotation_degrees(Vector3(90, 0, 0) * rot_speed)
	move_and_slide(Vector3(0, 1, 0).normalized() * 10)
	yield(get_tree().create_timer(1.0), "timeout")
	#if (get_rotation_degrees().x <= 0):
	if (self.global_transform.origin.y >= height):
		emit_signal("finished_moving")
		done = true
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#rot_speed = rad2deg(30)  # 30 deg/sec
	if (visible && !done):
		move_body()
