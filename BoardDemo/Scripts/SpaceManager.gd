extends Node

var pillars = ["Protect", "Invest", "Transform", "Repair"]
var rng = RandomNumberGenerator.new()
var main = null
var cur_player = null
var card = null
var choice_gui = null
var buttons = null
var click = null

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	choice_gui = get_node("/root/Main/GUI/ChoiceGUI")
	buttons = get_node("/root/Main/GUI/Choice Buttons")
	click = get_node("/root/Main/Environment/AudioStreamPlayer_Button")
	choice_gui.get_node("Control").visible = false
	for b in buttons.get_children():
		b.visible = false

func start_card_event(category, player):
	# var new_pause_state = not get_tree().paused
	# get_tree().paused = new_pause_state
	if main == null :
		main = get_node("/root/Main").card_data
	if !(category in main): # if the category doesn't exist
		print("category <", category, "> not found")
		player.active = false
		# new_pause_state = not get_tree().paused
		# get_tree().paused = new_pause_state
		return
	cur_player = player
	var pillar = pillars[rng.randi_range(0, 3)]
	var cards = main[category][pillar]
	card = cards[rng.randi_range(0, cards.size() - 1)] # picks a random card
	# assign fields to UI and display it
	# maybe add img path later?
	choice_gui.get_node("Control/Problem").text = card.name
	choice_gui.get_node("Control/ChoiceAText").text = card["choice-a"]["choice"]
	choice_gui.get_node("Control/ChoiceBText").text = card["choice-b"]["choice"]
	choice_gui.get_node("Control/ChoiceCText").text = card["choice-c"]["choice"]
	choice_gui.get_node("Control").visible = true
	for b in buttons.get_children():
		b.visible = true

func _on_ChoiceA_pressed():
	handle_events("choice-a")

func _on_ChoiceB_pressed():
	handle_events("choice-b")

func _on_ChoiceC_pressed():
	handle_events("choice-c")
	
# interprets the card values and hides the choice UI
func handle_events(c):
	click.play()
	var choice = card[c]
	cur_player.update_values(choice["self"], choice["society"], choice["sustainability"])
	cur_player.active = false
	# call something to hide UI
	choice_gui.get_node("Control").visible = false
	for b in buttons.get_children():
		b.visible = false
	# var new_pause_state = not get_tree().paused
	# get_tree().paused = new_pause_state
