extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("Control/CanvasLayer/Sprite")

func change_background(path):
	sprite.texture = load(path)
