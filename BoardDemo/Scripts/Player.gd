extends KinematicBody

const velocity = 10

var current = 0
var moving = false
var roll = 0
var rng = RandomNumberGenerator.new()

var sprite = null
var spaces = null
var roll_counter = null
var spinner = null

export var active = false
var self_score = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	spaces = get_node("/root/Main/Spaces").get_children()
	roll_counter = get_node("/root/Main/GUI/Top Bar/Rolls Counter/MarginContainer/Value")
	sprite = get_node("Sprite3D")
	spinner = get_node("/root/Main/GUI/Spinner")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) :
	if Input.is_action_pressed("ui_roll") && !moving && active:
		roll = rng.randi_range(1, 10)
		# update roll on UI and play spinner anim
		roll_counter.text = str(roll)
		spinner.play(roll)
		yield(spinner, "spinner_done")
		moving = true
	if moving:
		var pos = spaces[current].translation - global_transform.origin
		pos = Vector3(pos.x, 0, pos.z)
		move_and_slide(Vector3(pos.x, 0, pos.z).normalized() * velocity)
		sprite.set_flip_h(pos.x > 0)
		if pos.length() < 1 :
			if spaces[current].category != "Travel":
				roll -= 1
			current += 1
			if current >= spaces.size():
				current = 0
			moving = roll > 0
			if !moving: 
				# call tile script
				spaces[current].call_manager(self)

func update_values(s):
	self_score += s
	print(self_score)
