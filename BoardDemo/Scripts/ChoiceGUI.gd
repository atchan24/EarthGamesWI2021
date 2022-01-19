extends Node



var sprite
var label

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("Control/CanvasLayer/Sprite")
	label = sprite.get_node("Label")

func change_background(category, path):
	sprite.texture = load(path)
	label.text = category
