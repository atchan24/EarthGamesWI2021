extends StaticBody
class_name Space

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var main = null
var pillars = ["Protect", "Invest", "Transform", "Repair"]
var rng = RandomNumberGenerator.new()
var player = null

signal mouse_click(choice)

export var category : String

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
func _process(delta):
	pass

func start_card_event(obj):
	if category == null || category == "": # if the category doesn't exist
		return
	if main == null :
		main = get_node("/root/Main").card_data
	var pillar = pillars[rng.randi_range(0, 3)]
	var cards = main[category][pillar]
	# pick random card
	var card = cards[rng.randi_range(0, cards.size() - 1)]
	player = obj
	print("Card Name: " + card.name)
	print("Choice A: " + card["choice-a"]["choice"])
	print("Choice B: " + card["choice-b"]["choice"])
	print("Choice C: " + card["choice-c"]["choice"])
	# assign fields to UI and display it
	# var name
	# var img_path
	# var choice_a 
	# var choice_b 
	# var choice_c 
	# logic to show UI
	
	# add logic to detect signal to hide UI and adjust player values
	#yield(self, "mouse_click")
	#print("button has been clicked")
	# obj.update_values()
