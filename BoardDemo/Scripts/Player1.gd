extends KinematicBody

### THIS IS FOR PLAYER 1: Serp

signal player1lose(score)
signal player1add(score)


const velocity = 10


var current = 0
var moving = false
var roll = 0
var rng = RandomNumberGenerator.new()
var done = false
var has_rolled = false
var call_card = true

var sprite = null
var player_audio = null
var spaces = null
var roll_counter = null
var spinner = null
var bar = null

export var idle = ""
export var walk = ""
export var active = false
var self_score = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	spaces = get_node("/root/Main/Spaces").get_children()
	sprite = get_node("AnimatedSprite3D")
	bar = get_node("/root/Main/GUI/TopBar")
	bar.update_score(bar.get_self_surp(), self_score)
	player_audio = get_node("AudioStreamPlayer3D")
	#sprite.texture = load(texture)
	sprite.set_animation(idle)
	spinner = get_node("/root/Main/GUI/Spinner")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if done:
		sprite.set_animation(idle)
		if player_audio.playing:
			player_audio.stop()
		get_node("/root/Main").end_game()
		return
	if active && !moving:
		bar.update_score(bar.get_self_surp(), self_score)
	if Input.is_action_pressed("ui_roll") && !moving && active && !spinner.playing() && !has_rolled:
		rng.randomize()
		roll = rng.randi_range(1, 4)
		spinner.play(roll)
		yield(spinner, "spinner_done")
		moving = true
		has_rolled = true
		
#		if !counted_turn:
#			get_parent().cur_turn += 1
#			counted_turn = true
		
	if moving:
		var pos = spaces[current].translation - global_transform.origin
		pos = Vector3(pos.x, 0, pos.z)
		move_and_slide(Vector3(pos.x, 0, pos.z).normalized() * velocity * ceil(roll / 1.5))
		sprite.set_flip_h(pos.x > 0)
		if pos.length() < 1 :
			if spaces[current].category != "Travel":
				roll -= 1
			
#			# This stops the player at the last square
#			var temp = current + 1
#			if temp >= spaces.size():
#				roll = 0 # stop moving once you hit the end
#				done = true
				
			moving = roll > 0
			if !moving && call_card: 
				# call tile script
				spaces[current].call_manager(self)
				
			current += 1
			if current == 21:
				current = 0      # This lets the player go past the last square
		sprite.set_animation(walk)
		if !player_audio.playing:
			player_audio.play(0.0)
	else:
		sprite.set_animation(idle)
		if player_audio.playing:
			player_audio.stop()
		# This stops the player after the current_turn # = turn_max #
		if get_parent().cur_turn >= get_parent().final_turn:
			print("current: " + str(get_parent().cur_turn))
			print("final: " + str(get_parent().final_turn))
			done = true
		call_card = true

func is_done():
	return done

func update_values(s):
	self_score += s
	print("updating " + self.name + " self score: " + str(self_score))
	if s > 0:
		emit_signal("player1add", s)
	else:
		emit_signal("player1lose", s)


func get_score():
	return self_score
