extends KinematicBody

const velocity = 10

var current = 0
var moving = false
var roll = 0
var rng = RandomNumberGenerator.new()

var sprite = null
var spaces = null
var roll_counter = null

export var active = false
var self_score = 100
var society_score = 100
var sustainability_score = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	spaces = get_node("/root/Main/Spaces").get_children()
	roll_counter = get_node("/root/Main/GUI/Top Bar/Rolls Counter/MarginContainer/Value")
	sprite = get_node("AnimatedSprite3D")
	sprite.set_animation("BuffIdle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) :
	if Input.is_action_pressed("ui_roll") && !moving && active:
		moving = true
		roll = rng.randi_range(1, 10)
		# update roll on UI
		roll_counter.text = str(roll)
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
		sprite.set_animation("BuffWalk")
	else:
		sprite.set_animation("BuffIdle")

func update_values(s1, s2, s3):
	self_score += s1
	society_score += s2
	sustainability_score += s3
	print(self_score)
	print(society_score)
	print(sustainability_score)
