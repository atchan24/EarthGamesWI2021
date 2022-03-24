extends StaticBody

var manager = null

export var category : String

var bonus_value = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	manager = get_node("/root/Main/Spaces")

func call_manager(obj):
#	print("players invited: " + str(players_invited))
	manager.start_card_event(category, obj, bonus_value, false)

func update_val(val):
	bonus_value = bonus_value + val
