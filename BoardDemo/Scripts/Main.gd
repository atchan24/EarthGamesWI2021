extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var card_data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://Assets/cards.json", file.READ)
	var text = file.get_as_text()
	var res = JSON.parse(text)
	if res.error == OK:
		card_data = res.result
	else:
		print("Error: ", res.error)
		print("Error Line: ", res.error_line)
		print("Error String: ", res.error_string)
	file.close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
