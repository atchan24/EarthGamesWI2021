extends Node

var rng = RandomNumberGenerator.new()
var manager = null
var card_data = null
var cur_player = null
var cur_bonus = 0
var card = null
var choice_gui = null
var popup_ACchoice
var buttons = null
var assets = null
var cur_assets = null
var click = null
var top_bar = null

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	manager = get_node("/root/Main")
	choice_gui = get_node("/root/Main/GUI/ChoiceGUI")
	popup_ACchoice = get_node("/root/Main/GUI/PopupActionCardChoice")
	buttons = get_node("/root/Main/GUI/Choice Buttons")
	click = get_node("/root/Main/AmbientAudio/Click")
	choice_gui.get_node("Control").visible = false
	choice_gui.get_node("Control/CanvasLayer/Sprite").visible = false
	assets = get_node("/root/Main/Environment/Category Assets")
	top_bar = get_node("/root/Main/GUI/TopBar")
	for b in buttons.get_children():
		b.visible = false

func start_card_event(category, player, bonus):
	# var new_pause_state = not get_tree().paused
	# get_tree().paused = new_pause_state
	if card_data == null :
		card_data = manager.card_data
	if !(category in card_data): # if the category doesn't exist
		#print("category <", category, "> not found")
		#player.active = false
		print("no category assigned, randomizing values")
		var choices = ["choice-a", "choice-b", "choice-c"]
		cur_player = player
		cur_bonus = bonus
		handle_events_demo(choices[rng.randi_range(0, 2)])
		return
	for c in assets.get_children():
		if (c.name == category):
			cur_assets = c
	cur_player = player
	cur_bonus = bonus
	var cards = card_data[category]
	card = cards[rng.randi_range(0, cards.size() - 1)] # picks a random pillar from that card space
	# assign fields to UI and display it
	choice_gui.get_node("Control/Prompt").text = card.prompt
	choice_gui.get_node("Control/ChoiceAText").text = card["self"]["choice"]
	choice_gui.get_node("Control/ChoiceBText").text = card["society"]["choice"]
	choice_gui.get_node("Control/ChoiceCText").text = card["sustainability"]["choice"]
	choice_gui.get_node("Control").visible = true
	choice_gui.get_node("Control/CanvasLayer/Sprite").visible = true
	# img path
	choice_gui.change_background("res://Assets/Cards/Card_" + category.replace(" ", "") + ".png")
	
	popup_ACchoice.reset_popup(category)
	
	for b in buttons.get_children():
		b.visible = true
	var top_
	top_bar.visible = false
	top_bar.get_counter().text = ""

func _on_ChoiceA_pressed():
	handle_events_demo("choice-a")

func _on_ChoiceB_pressed():
	handle_events_demo("choice-b")

func _on_ChoiceC_pressed():
	handle_events_demo("choice-c")

# use this version of handle_events for Earth Week demo
func handle_events_demo(c):
	click.play()
	get_node("/root/Main/GUI/TopBar").visible = true
	var s1 = 0
	var s2 = 0
	var s3 = 0
	if c == "choice-a":
		s1 = 5
	elif c == "choice-b":
		s1 = -5
		s2 = 5
		top_bar.anim_add_society()          # anim to +5 society 
	elif c == "choice-c":
		s1 = -5
		s3 = 5
		top_bar.anim_add_sustainability()   # anim to +5 sustainability
		
	cur_player.update_values(s1 + cur_bonus)
	# send signal from player scripts emitted with update_value()
	# attach signals to top_bar.gd to play anims for player +/- 5.
	manager.update_score(s2, s3)
	
	choice_gui.get_node("Control").visible = false
	choice_gui.get_node("Control/CanvasLayer/Sprite").visible = false
	for b in buttons.get_children():
		b.visible = false
	for a in cur_assets.get_children():
		if !(a.visible):
			a.visible = true
			yield(a, "finished_moving")
			break
	
	# Popup in top left corner
	popup_ACchoice.popup()
	yield(get_tree().create_timer(5.0), "timeout")
	
	cur_player.has_rolled = false
	cur_player.active = false


# interprets the card values and hides the choice UI
func handle_events(c):
	click.play()
	var choice = card[c]
	cur_player.update_values(choice["self"] + cur_bonus)
	manager.update_score(choice["society"], choice["sustainability"])
	# add logic to increase bonus of a future space defined by offset
	# need to retrive current space to determine offset by relative position
	# call something to hide UI
	choice_gui.get_node("Control").visible = false
	choice_gui.get_node("Control/CanvasLayer/Sprite").visible = false
	for b in buttons.get_children():
		b.visible = false
	for a in assets.get_children():
		if !(a.visible):
			a.visible = true
			break
	cur_player.active = false
	# var new_pause_state = not get_tree().paused
	# get_tree().paused = new_pause_state
