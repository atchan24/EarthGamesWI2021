extends Node

onready var cam = get_node("/root/Main/Players/Player/PlayerCamera")

var players : Array
var active_player : int
var end = false

func next_player():
	active_player = (active_player + 1) % players.size()
	var cur = 0
	while cur < players.size():
		if !players[active_player].is_done():
			players[active_player].set_active(true)
			# current method of changing cams is a little jank/jerky
			players[active_player].add_child(cam)
			break
		else:
			active_player = (active_player + 1) % players.size()
			cur += 1
	if cur == players.size():
		end = true
		get_node("/root/Main").end_game()

# Called when the node enters the scene tree for the first time.
func _ready():
	players = self.get_children()
	active_player = 0
	players[active_player].set_active(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !players[active_player].active && !end:
		players[active_player].remove_child(cam)
		next_player()
