extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var players : Array
var active_player : int
var cam = null;

func next_player():
	var init = active_player
	active_player = (active_player + 1) % players.size()
	while init != active_player:
		if !players[active_player].is_done():
			players[active_player].active = true
			# current method of changing cams is a little jank/jerky
			players[active_player].add_child(cam)
			break
		else:
			active_player = (active_player + 1) % players.size()
	if init == active_player:
		get_node("/root/Main").end_game()

# Called when the node enters the scene tree for the first time.
func _ready():
	cam = get_node("/root/Main/Players/Player/PlayerCamera")
	players = self.get_children()
	active_player = 0
	players[active_player].active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !players[active_player].active:
		players[active_player].remove_child(cam)
		next_player()
