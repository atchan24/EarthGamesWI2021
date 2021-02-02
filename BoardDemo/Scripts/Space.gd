extends StaticBody
class_name Space

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var main = null
var pillars = ["Protect", "Invest", "Transform", "Repair"]
var rng = RandomNumberGenerator.new()

export var category : String

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

func start_card_event():
	if main == null :
		main = get_node("/root/Main").card_data
	var pillar = pillars[rng.randi_range(0, 3)]
	pillar = "Protect"
	var cards = main[category][pillar]
	# pick random card
	# var card = cards[rng.randi_range(0, cards.size() - 1]
	# assign fields
	# var name
	# var img_path
	# var choice_a 
	# var choice_b 
	# var choice_c 
	# yield()
	# make some kind of choice
	
	# some logic to choose a choice
	# return {health: , happiness: , money: }
