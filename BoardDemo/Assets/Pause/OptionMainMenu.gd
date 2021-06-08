extends Control

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (get_parent().get_node("MainButtons").visible == true):
		self.visible = false


func _on_return_pressed():
	get_parent().get_node("MainButtons").visible = true
	self.visible = false
