extends Node

signal P1_active
signal P2_active
signal P3_active
signal P4_active

var players : Array
var active_player : int
var cam = null;
var end = false

var cur_turn = 0
var final_turn = 32  # each player gets 8 turns


# Called when the node enters the scene tree for the first time.
func _ready():
	cam = get_node("/root/Main/Players/Player1/PlayerCamera")
	players = self.get_children()
	active_player = 0
	players[active_player].active = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !players[active_player].active && !end:
		players[active_player].remove_child(cam)
		next_player()



func next_player():
	cur_turn += 1
	print("current turn: ", cur_turn)
	
	active_player = (active_player + 1) % players.size()
	var cur = 0                   # cur gets bigger when each players 
								  # reaches their 'done' = true
	while cur < players.size():
		if !players[active_player].is_done():
			players[active_player].active = true
			# current method of changing cams is a little jank/jerky
			players[active_player].add_child(cam)
			active_player() # Emits signal to ui topBar
			break
		else:
			# If the next player is already done.
			active_player = (active_player + 1) % players.size()
			cur += 1
			print("cur: ", cur)
	
	if cur == players.size():
		end = true
		get_node("/root/Main").end_game()


func active_player():
	print("Turn Queue Active Player: ", active_player + 1)
	print("Turn Queue Current Turn: ", cur_turn)
	if active_player == 0:
		emit_signal("P1_active")
	elif active_player == 1:
		emit_signal("P2_active")
	elif active_player == 2:
		emit_signal("P3_active")
	elif active_player == 3:
		emit_signal("P4_active")


