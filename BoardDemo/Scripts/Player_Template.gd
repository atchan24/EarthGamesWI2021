extends KinematicBody

export var player_number = "player#"
export var player_name_upper = "Player"
export var player_name_lower = "player"
export var self_score = 15
export var max_movement = 10
#taco
#signal player1lose(score)  
#signal player1add(score)
signal playerLose(score, player_name_upper)
signal playerAdd(score, player_name_upper)

#signal player1lose(score)
#signal player1add(score)


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

onready var invite_screen = get_node("/root/Main/GUI/TopBar/Invite")

# Called when the node enters the scene tree for the first time.
func _ready():
	spaces = get_node("/root/Main/Spaces").get_children()
	sprite = get_node("AnimatedSprite3D")
	bar = get_node("/root/Main/GUI/TopBar")
	var funcname = "get_self_%s"%[player_name_lower]
	bar.update_score(bar.call(funcname), self_score)
	player_audio = get_node("AudioStreamPlayer3D")
	#sprite.texture = load(texture)
	print("SPRITE LOADED: ")
	print(sprite)
	sprite.set_animation(idle)
	spinner = get_node("/root/Main/GUI/Spinner")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if done:
		sprite.set_animation(idle)
		if player_audio.playing:
			player_audio.stop()
		get_node("/root/Main").end_game()
		return
	if active && !moving:
		var funcname = "get_self_%s"%[player_name_lower]
		bar.update_score(bar.call(funcname), self_score)
	if Input.is_action_pressed("ui_roll") && !moving && active && !spinner.playing() && !has_rolled:
		rng.randomize()
		roll = rng.randi_range(1, max_movement)
		spinner.play(roll)
		yield(spinner, "spinner_done")
		moving = true
		has_rolled = true
		
#		if !counted_turn:
#			get_parent().cur_turn += 1
#			counted_turn = true
		
	if moving and roll > 0:
		var pos = spaces[current].translation - global_transform.origin
		pos = Vector3(pos.x, 0, pos.z)
		move_and_slide(Vector3(pos.x, 0, pos.z).normalized() * velocity * ceil(roll / 1.5))
		sprite.set_flip_h(pos.x > 0)
		if pos.length() < 1 and roll > 0:
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
		invite_screen.update_invite_values()

func is_done():
	return done

func update_values(s):
	self_score += s
	print(self.name + ": " + str(self_score))
	if s > 0:
		emit_signal("playerAdd", s, player_name_upper)
	else:
		emit_signal("playerLose", s, player_name_upper)


func get_score():
	return self_score
