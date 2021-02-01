extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var players : Array
var active_player : int

func next_player():
	active_player = active_player + 1 % players.size()
	players[active_player].active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	players = self.get_children()
	active_player = 0
	players[active_player].active = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !players[active_player].active:
		next_player()
