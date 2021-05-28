extends Node2D

var anims = ['BuffWalk', 'BeatWalk', 'JogWalk', 'SurpWalk']
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	get_node("AnimatedSprite").play(anims[rng.randi_range(0, 3)])
