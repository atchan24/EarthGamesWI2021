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
var invite_screen = null
var invite_popup = null

var first_round = false
var _round = 0

var option_clicked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	manager = get_node("/root/Main")
	choice_gui = get_node("/root/Main/GUI/ChoiceGUI")
	popup_ACchoice = get_node("/root/Main/GUI/TopBar/PopupActionCardChoice")
	buttons = get_node("/root/Main/GUI/Choice Buttons")
	click = get_node("/root/Main/AmbientAudio/Click")
	choice_gui.get_node("Control").visible = false
	choice_gui.get_node("Control/CanvasLayer/Sprite").visible = false
	assets = get_node("/root/Main/Environment/Category Assets")
	top_bar = get_node("/root/Main/GUI/TopBar")
	invite_screen = get_node("/root/Main/GUI/TopBar/Invite")
	invite_popup = invite_screen.get_node("AnimationPlayer")
	
	top_bar.connect("turnOver", self, "handle_turnOver")
	for b in buttons.get_children():
		b.visible = false


func start_card_event(category, player, bonus, end_turn):
#	var n = rng.randi_range(0, 4)
#	if n == 0:
#		start_other_card_event(player)
#	else:
	start_action_card_event(category, player, bonus, end_turn)


func start_action_card_event(category, player, bonus, end_turn):
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
		handle_events_demo(choices[rng.randi_range(0, 2)], end_turn)
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
	# img path
	#choice_gui.change_background(category, "res://Assets/Cards/Card_" + category.replace(" ", "") + ".png")
	choice_gui.change_background(category, "res://Assets/Cards/" + category.replace(" ", "") + ".png")
	
	popup_ACchoice.reset_popup(category)
	
	for b in buttons.get_children():
		b.visible = true
	top_bar.get_counter().text = ""
	
	choice_gui.get_node("AnimationPlayer").play("DrawCard")
	top_bar.get_node("AnimationPlayer").play("UIDrawCard")


func _on_ChoiceA_pressed():
	if !option_clicked:
		option_clicked = true
		handle_events_demo("choice-a", false)

func _on_ChoiceB_pressed():
	if !option_clicked:
		option_clicked = true
		handle_events_demo("choice-b", false)

func _on_ChoiceC_pressed():
	if !option_clicked:
		option_clicked = true
		handle_events_demo("choice-c", false)

func check_square_for_teammates():
	pass

# use this version of handle_events for Earth Week demo
func handle_events_demo(c, end_turn):
	click.play()
	
	var s1 = 0
	var s2 = 0
	var s3 = 0
	if c == "choice-a":
		s1 = 5
		cur_player.update_values(s1);
	elif c == "choice-b":
		s1 = -5
		print("players invited: " + str(Global.players_invited))
		s2 = 5 + (cur_bonus * Global.players_invited)
#		top_bar.get_node('Control/AnimationPlayer/AddSociety').text = "+" + str(s2)
#		top_bar.anim_add_society()          # anim to +5 society 
	elif c == "choice-c":
		s1 = -5
		print("players invited: " + str(Global.players_invited))
		s3 = 5 + (cur_bonus * Global.players_invited)
#		top_bar.get_node('Control/AnimationPlayer/AddSustainability').text = "+" + str(s3)
#		top_bar.anim_add_sustainability()   # anim to +5 sustainability
	
	Global.players_invited = 0
	invite_screen.choice = c
	print("choice: " + String(c))
	
	if c != "choice-a" and !end_turn:
		invite_screen.visible = true
		invite_screen.update_invite_values()
		invite_popup.play_backwards("inviteMenu")
		
#	invite_popup.play_backwards("inviteMenu")
#	choice_gui.get_node("AnimationPlayer").play_backwards("DrawCard")
	
#	cur_player.update_values(s1 + cur_bonus)
	# send signal from player scripts emitted with update_value()
	# attach signals to top_bar.gd to play anims for player +/- 5.
	
#
	choice_gui.get_node("AnimationPlayer").play_backwards("DrawCard")
#	top_bar.get_node("AnimationPlayer").play_backwards("UIDrawCard")
	
	if end_turn or c == "choice-a":
		if c != "choice-a":
			invite_popup.play("inviteMenu")
		manager.update_score(s2, s3)
		yield(get_tree().create_timer(3.0), "timeout")
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
		option_clicked = false
		# This waits for the popup Action Card Choice to pop down
		popup_post_card_event(s1, s2, s3)
#	ALL OF THIS NEEDS TO BE MOVED


func popup_post_card_event(s1, s2, s3):
	#If the first round has not been completed
	if first_round == false:               
		if s1 == 5:
			top_bar.popup_postChoice_self()
		elif s2 == 5:
			top_bar.popup_postChoice_society()
		elif s3 == 5:
			top_bar.popup_postChoice_sustainability()
		else:
			top_bar.popup_postChoice_nothing()
	else:
		handle_turnOver()
#		invite_screen.update_invite_values()


func start_other_card_event(player):
	print("Other card event")
	cur_player = player
	top_bar.get_counter().text = ""
	popup_post_card_event(0, 0, 0)


func handle_turnOver():
	# needs a signal from 'next' button on post-choice popup
	cur_player.has_rolled = false
	cur_player.active = false
	_round += 1
	if _round >=4:
		first_round = true


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
