extends Node

var pillars = ["Protect", "Invest", "Transform", "Repair"]
var rng = RandomNumberGenerator.new()
var main = null
var cur_player = null
var card = null

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

func start_card_event(category, player):
	if main == null :
		main = get_node("/root/Main").card_data
	if !(category in main): # if the category doesn't exist
		print("category <", category, "> not found")
		return
	cur_player = player
	var pillar = pillars[rng.randi_range(0, 3)]
	var cards = main[category][pillar]
	card = cards[rng.randi_range(0, cards.size() - 1)] # picks a random card
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

func _on_ChoiceA_pressed():
	handle_events(0)

func _on_ChoiceB_pressed():
	handle_events(1)

func _on_ChoiceC_pressed():
	handle_events(2)
	
# interprets the card values and hides the choice UI
func handle_events(c):
	var choice = card[c]
	cur_player.update_values(choice["self"], choice["society"], choice["sustainability"])
	# call something to hide UI
