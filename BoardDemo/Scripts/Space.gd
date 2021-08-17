extends StaticBody

var manager = null

export var category : String

var bonus_value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	manager = get_node("/root/Main/Spaces") # refer to space manager script

func call_manager(obj):
	manager.start_card_event(category, obj, bonus_value)

func update_val(val):
	bonus_value = bonus_value + val
