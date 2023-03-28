extends Node

var rng = RandomNumberGenerator.new()
var manager = null
var card_data = null
var yearly_event_data = null
var cur_player = null
var cur_bonus = 5
var card = null
var choice_gui = null
var popup_ACchoice
var buttons = null
var assets = null
var cur_assets = null
var click = null
var top_bar = null
var self_anim_player = null
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
	self_anim_player = top_bar.get_node("Control/SelfAnimationPlayer")
	invite_screen = get_node("/root/Main/GUI/TopBar/Invite")
	invite_popup = invite_screen.get_node("AnimationPlayer")
	
	top_bar.connect("turnOver", self, "handle_turnOver")
	for b in buttons.get_children():
		b.visible = false


func start_yearly_card_event():
	var x = null
	var y = null
	var category = null
	if yearly_event_data == null :
		yearly_event_data = manager.yearly_event_data
	print("Yearly card event")
	choice_gui.get_node("AnimationPlayer").play("YearlyEvent")
	top_bar.get_counter().text = ""
	manager.get_node("GUI/TextureButton").show()
	popup_post_card_event(0, 0, 0)
	#pause game (dont let player spin)
	y = rng.randi_range(5, 20)
	#choose card depending on cur_scores
	#add or subtract points according to card
	if manager.get_society() < y:
		category = "SocietyBad"
		x = 1
		print("Yearly event card: Society Bad")
	elif manager.get_sustainability() < y:
		category = "SustainabilityBad"
		x = 2
		print("Yearly event card: Sustain Bad")
	elif manager.get_society() >= y:
		category = "SocietyGood"
		x = 3
		print("Yearly event card: Society Good")
	elif manager.get_sustainability() >= y:
		category = "SustainabilityGood"
		x = 4
		print("Yearly event card: Sustain Good")
	var cards = yearly_event_data[category]
	card = cards[rng.randi_range(0, cards.size() - 1)] # picks a random card from that status
	choice_gui.get_node("YearlyEvent/CanvasLayer/Sprite/Label2/Label").text \
		= card.prompt
		
	handle_yearly_card_event(x)



func handle_yearly_card_event(x):
	print("Yearly event points updated")
	# Handles adding or subtracting points based on the 
	# Yearly event card drawn
	var Surp = get_node("/root/Main/Players/Player1")
	var Buff = get_node("/root/Main/Players/Player2")
	var Jog = get_node("/root/Main/Players/Player3")
	var Beat = get_node("/root/Main/Players/Player4")
	if x == 1: # Soc bad
		manager.update_score(-4, 0)
		Surp.update_values(-2)
		yield(self_anim_player, "animation_finished")
		Buff.update_values(-2)
		yield(self_anim_player, "animation_finished")
		Jog.update_values(-2)
		yield(self_anim_player, "animation_finished")
		Beat.update_values(-2)
	if x == 2: # Sus bad
		manager.update_score(0, -4)
		Surp.update_values(-2)
		yield(self_anim_player, "animation_finished")
		Buff.update_values(-2)
		yield(self_anim_player, "animation_finished")
		Jog.update_values(-2)
		yield(self_anim_player, "animation_finished")
		Beat.update_values(-2)
	if x == 3: # Soc good
		manager.update_score(4, 0)
		Surp.update_values(1)
		yield(self_anim_player, "animation_finished")
		Buff.update_values(1)
		yield(self_anim_player, "animation_finished")
		Jog.update_values(1)
		yield(self_anim_player, "animation_finished")
		Beat.update_values(1)
	if x == 4: # Sus good
		manager.update_score(0, 4)
		Surp.update_values(1)
		yield(self_anim_player, "animation_finished")
		Buff.update_values(1)
		yield(self_anim_player, "animation_finished")
		Jog.update_values(1)
		yield(self_anim_player, "animation_finished")
		Beat.update_values(1)


func _on_YearlyEventNext_pressed():
	#emit_signal("yearly_event_complete")
	choice_gui.get_node("AnimationPlayer").play_backwards("YearlyEvent")
	manager.get_node("GUI/TextureButton").hide()
	top_bar.get_node("AnimationPlayer").play_backwards("UIDrawCard")
	#unpause game


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
	choice_gui.change_background(category, "res://Assets/Cards/" + category.replace(" ", "") + ".png")
	
	popup_ACchoice.reset_popup(category, player)
	
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
		cur_player.update_values(s1)
		# ^^^
	elif c == "choice-b":
		s1 = -5
		print("players invited: " + str(Global.players_invited))
		s2 = 5 + (cur_bonus * Global.players_invited)
	elif c == "choice-c":
		s1 = -5
		print("players invited: " + str(Global.players_invited))
		s3 = 5 + (cur_bonus * Global.players_invited)
	
	Global.players_invited = 0
	invite_screen.choice = c
	print("choice: " + String(c))
	
	if c != "choice-a" and !end_turn:
		invite_screen.visible = true
		invite_screen.update_invite_values()
		invite_popup.play_backwards("inviteMenu")
		
#	invite_popup.play_backwards("inviteMenu")
	
#	cur_player.update_values(s1 + cur_bonus)
	# send signal from player scripts emitted with update_value()
	# attach signals to top_bar.gd to play anims for player +/- 5.
	
#
	choice_gui.get_node("AnimationPlayer").play_backwards("DrawCard")
	
	if end_turn or c == "choice-a":
		if c != "choice-a":
			invite_popup.play("inviteMenu")
		manager.update_score(s2, s3)
		# ^^^^ This line updates score AND plays anims for soc and sus score
		# ^^^^ in GameManager.gd which calls anims from top_bar
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
		elif s2 >= 1:
			top_bar.popup_postChoice_society()
		elif s3 >= 1:
			top_bar.popup_postChoice_sustainability()
		else:
			top_bar.popup_postChoice_nothing()
	else:
		handle_turnOver()
#		invite_screen.update_invite_values()





func handle_turnOver():
	# needs a signal from 'next' button on post-choice popup
	top_bar.get_node("AnimationPlayer").play_backwards("UIDrawCard")
	cur_player.has_rolled = false
	cur_player.active = false
	_round += 1
	if _round >=4:
		first_round = true


# interprets the card values and hides the choice UI
func handle_events(c):
	click.play()
	var choice = card[c]
	cur_player.update_values(choice["self"]) #+ cur_bonus)
	# ^^^^ This line updates score AND plays anims for self scores
	# ^^^^ in PlayerTemplate.gd which emits signal to top_bar (somehow?)
	manager.update_score(choice["society"], choice["sustainability"])
	# ^^^^ This line updates score AND plays anims for soc and sus score
	# ^^^^ in GameManager.gd which calls anims from top_bar
	
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



