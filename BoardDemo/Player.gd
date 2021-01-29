extends KinematicBody

const velocity = 10

var spaces = []
var current = 0
var moving = false
var roll = 0
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	spaces = get_node("/root/Main/Spaces").get_children()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) :
	if Input.is_action_pressed("ui_roll") && !moving :
		moving = true
		roll = rng.randi_range(1, 10)
		# update roll on UI
	if moving:
		var pos = spaces[current].translation - global_transform.origin
		pos = Vector3(pos.x, 0, pos.z)
		move_and_slide(Vector3(pos.x, 0, pos.z).normalized() * velocity)
		if pos.length() < 1 :
			current += 1
			roll -= 1
			if current >= spaces.size():
				current = 0
			moving = roll > 0
