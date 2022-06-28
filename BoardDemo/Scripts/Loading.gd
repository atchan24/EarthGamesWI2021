extends Node2D

var anims = ['BuffWalk', 'BeatWalk', 'JogWalk', 'SurpWalk']
var texts = ['Press space to spin and move your avatar','Earn 5 Self points for choosing the self option','Earn 1 Society or Sustainability point by investing 5 Self points','Invite a friend to your space to earn more points!','Collaboration is the key to success. Work together if you can!']
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	get_node("AnimatedSprite").play(anims[rng.randi_range(0, 3)])
	get_node("Text").text = texts[rng.randi_range(0,4)]
