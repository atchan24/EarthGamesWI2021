extends StaticBody

var manager = null

export var category : String

# Called when the node enters the scene tree for the first time.
func _ready():
	manager = get_node("/root/Main/Spaces")

func call_manager(obj):
	manager.start_card_event(category, obj)
