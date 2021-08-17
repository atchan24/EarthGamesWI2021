extends KinematicBody

const velocity = 10

var current = 0
var moving = false
var roll = 0
var rng = RandomNumberGenerator.new()
var done = false
var has_rolled = false
var active = false
var self_score = 30

onready var sprite = get_node("/root/Main/Spaces").get_children()
onready var player_audio = get_node("AudioStreamPlayer3D")
onready var spinner = get_node("/root/Main/GUI/Spinner")
onready var bar = get_node("/root/Main/GUI/TopBar")

var spaces = null
var roll_counter = null

export var idle = ""
export var walk = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite3D").set_animation(idle)
	bar.update_score(bar.get_self(), self_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if done:
		sprite.set_animation(idle)
		if player_audio.playing:
			player_audio.stop()
		return
	if active && !moving:
		bar.update_score(bar.get_self(), self_score)
	if Input.is_action_pressed("ui_roll") && !moving && active && !spinner.playing() && !has_rolled:
		rng.randomize()
		roll = rng.randi_range(1, 10)
		spinner.play(roll)
		yield(spinner, "spinner_done")
		moving = true
		has_rolled = true
	if moving:
		var pos = spaces[current].translation - global_transform.origin
		pos = Vector3(pos.x, 0, pos.z)
		move_and_slide(Vector3(pos.x, 0, pos.z).normalized() * velocity * ceil(roll / 1.5))
		sprite.set_flip_h(pos.x > 0)
		if pos.length() < 1 :
			if spaces[current].category != "Travel":
				roll -= 1
			var temp = current + 1
			if temp >= spaces.size():
				roll = 0 # stop moving once you hit the end
				done = true
			moving = roll > 0
			if !moving: 
				# call tile script
				spaces[current].call_manager(self)
			current += 1
		sprite.set_animation(walk)
		if !player_audio.playing:
			player_audio.play(0.0)
	else:
		sprite.set_animation(idle)
		if player_audio.playing:
			player_audio.stop()

func is_done():
	return done
	
func is_active():
	return active

func set_active(state):
	active = state
	
func set_rolled(state):
	has_rolled = state

func update_values(s):
	self_score += s
	print(self.name + ": " + str(self_score))
	
func get_score():
	return self_score
