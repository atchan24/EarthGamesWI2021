extends KinematicBody

const velocity = 10

var current = 0
var moving = false
var roll = 0
var rng = RandomNumberGenerator.new()

var spaces = null
var roll_counter = null

export var active = false
# export var health = 100
# export var happiness = 100
# export var money = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	spaces = get_node("/root/Main/Spaces").get_children()
	roll_counter = get_node("/root/Main/GUI/Rolls Counter/MarginContainer/Value")

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
		if pos.length() < 1 :
			if spaces[current].category != "Travel":
				roll -= 1
			current += 1
			if current >= spaces.size():
				current = 0
			moving = roll > 0
			if !moving: 
				# call tile script
				# var values = spaces[current].start_card_event()
				# values.resume()
				# assign values
				active = false
