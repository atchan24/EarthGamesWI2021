extends Control


signal turnOver

onready var main = get_parent().get_parent()

onready var spaces = main.get_node("Spaces")

onready var players = main.get_node("Players")
onready var player1 = players.get_node("Player1")
onready var player2 = players.get_node("Player2")
onready var player3 = players.get_node("Player3")
onready var player4 = players.get_node("Player4")

onready var tween = get_node("Control/Tween")
onready var self_bar_surp = get_node("VBoxContainer/SelfBar_Surp")
onready var self_bar_buff = get_node("VBoxContainer/SelfBar_Buff")
onready var self_bar_jog = get_node("VBoxContainer/SelfBar_Jog")
onready var self_bar_beat = get_node("VBoxContainer/SelfBar_Beat")
onready var society_bar = get_node("Control/SocietyBar")
onready var sustain_bar = get_node("Control/SustainBar")

onready var postChoice_popup = get_node("PostChoicePopup")
onready var postChoice_popup_anim = postChoice_popup.get_node("AnimationPlayer")
onready var postChoice_popup_text = postChoice_popup.get_node("TextureRect/TextureButton/RichTextLabel")
onready var postChoice_popup_sprite = postChoice_popup.get_node("Node2D")

func _ready():
	players.connect("P1_active", self, "handle_P1_active")
	players.connect("P2_active", self, "handle_P2_active")
	players.connect("P3_active", self, "handle_P3_active")
	players.connect("P4_active", self, "handle_P4_active")
	
	self_bar_surp.rect_scale = Vector2(1.1, 1.1)
	self_bar_buff.modulate = Color(0.7, 0.7, 0.7)
	self_bar_jog.modulate = Color(0.7, 0.7, 0.7)
	self_bar_beat.modulate = Color(0.7, 0.7, 0.7)
	$Control/button_big_blue/PressSpinner/AnimationPlayer.play("PressSpinner")

func update_score(node, score):
	node.value = score

func get_counter():
	return get_node("RollsCounter")	
	
func get_self_surp():
	return self_bar_surp

func get_self_buff():
	return self_bar_buff

func get_self_jog():
	return self_bar_jog

func get_self_beat():
	return self_bar_beat

func get_society():
	return society_bar

func get_sustain():
	return sustain_bar

# Highlight the player's UI whose turn it is.
func handle_P1_active():
	print("CHICKEN BANANANANANANANA")
	self_bar_surp.rect_scale = Vector2(1.1, 1.1)
	self_bar_buff.rect_scale = Vector2(1.0, 1.0)
	self_bar_beat.rect_scale = Vector2(1.0, 1.0)
	self_bar_surp.modulate = Color(1, 1, 1)
	self_bar_buff.modulate = Color(0.7, 0.7, 0.7)
	self_bar_jog.modulate = Color(0.7, 0.7, 0.7)
	self_bar_beat.modulate = Color(0.7, 0.7, 0.7)
	postChoice_popup_sprite.get_node("Surp").visible = true
	postChoice_popup_sprite.get_node("Buff").visible = false
	postChoice_popup_sprite.get_node("Jog").visible = false
	postChoice_popup_sprite.get_node("Beat").visible = false
	update_turn_label()

func handle_P2_active():
	self_bar_buff.rect_scale = Vector2(1.1, 1.1)
	self_bar_jog.rect_scale = Vector2(1.0, 1.0)
	self_bar_beat.rect_scale = Vector2(1.0, 1.0)
	self_bar_surp.modulate = Color(0.7, 0.7, 0.7)
	self_bar_buff.modulate = Color(1, 1, 1)
	self_bar_jog.modulate = Color(0.7, 0.7, 0.7)
	self_bar_beat.modulate = Color(0.7, 0.7, 0.7)
	postChoice_popup_sprite.get_node("Surp").visible = false
	postChoice_popup_sprite.get_node("Buff").visible = true
	postChoice_popup_sprite.get_node("Jog").visible = false
	postChoice_popup_sprite.get_node("Beat").visible = false
	update_turn_label()

func handle_P3_active():
	self_bar_buff.rect_scale = Vector2(1.0, 1.0)
	self_bar_jog.rect_scale = Vector2(1.1, 1.1)
	self_bar_beat.rect_scale = Vector2(1.0, 1.0)
	self_bar_surp.modulate = Color(0.7, 0.7, 0.7)
	self_bar_buff.modulate = Color(0.7, 0.7, 0.7)
	self_bar_jog.modulate = Color(1, 1, 1)
	self_bar_beat.modulate = Color(0.7, 0.7, 0.7)
	postChoice_popup_sprite.get_node("Surp").visible = false
	postChoice_popup_sprite.get_node("Buff").visible = false
	postChoice_popup_sprite.get_node("Jog").visible = true
	postChoice_popup_sprite.get_node("Beat").visible = false
	update_turn_label()

func handle_P4_active():
	self_bar_surp.rect_scale = Vector2(1.0, 1.0)
	self_bar_jog.rect_scale = Vector2(1.0, 1.0)
	self_bar_beat.rect_scale = Vector2(1.1, 1.1)
	self_bar_surp.modulate = Color(0.7, 0.7, 0.7)
	self_bar_buff.modulate = Color(0.7, 0.7, 0.7)
	self_bar_jog.modulate = Color(0.7, 0.7, 0.7)
	self_bar_beat.modulate = Color(1, 1, 1)
	postChoice_popup_sprite.get_node("Surp").visible = false
	postChoice_popup_sprite.get_node("Buff").visible = false
	postChoice_popup_sprite.get_node("Jog").visible = false
	postChoice_popup_sprite.get_node("Beat").visible = true
	update_turn_label()


func update_turn_label():
	var turn = spaces._round
	
	$Control/button_big_blue/PressSpinner/Label.text = \
		"Press spacebar to spin.  There are " \
		+ str((32-turn)) + " seasons Left"
	$Control/button_big_blue/PressSpinner/AnimationPlayer.play("PressSpinner")
	if turn % 4 == 0: 
		$Control/button_big_blue/PressSpinner/BigLabel.text = "Only" + str((32-turn)/4) + " Years Left!!!"
		$Control/button_big_blue/PressSpinner/BigLabel.visible = true
		yield(get_tree().create_timer(3.0), "timeout")
		spaces.start_yearly_card_event()
		$AnimationPlayer.play("UIDrawCard")
		$Control/button_big_blue/PressSpinner/BigLabel.visible = false
	
	turn += 1


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE:
			$Control/button_big_blue/PressSpinner/AnimationPlayer.play_backwards("PressSpinner")


# ANIMATIONS
func _on_playerAdd(score, player_name_upper):
	var nodeLocation = "VBoxContainer/SelfBar_%s/Add%s"%[player_name_upper, player_name_upper]
	get_node(nodeLocation).text = str("+") + str(score)
	var anim_name = "Add%s"%[player_name_upper]
	$Control/SelfAnimationPlayer.play(anim_name)
	update_score($VBoxContainer/SelfBar_Surp, player1.self_score)
	update_score($VBoxContainer/SelfBar_Buff, player2.self_score)
	update_score($VBoxContainer/SelfBar_Jog, player3.self_score)
	update_score($VBoxContainer/SelfBar_Beat, player4.self_score)
	$VBoxContainer/SelfBar_Surp/SelfScore.text = " Surp: " + str(get_self_surp().value) + "-" + str(get_self_surp().max_value)
	$VBoxContainer/SelfBar_Buff/SelfScore.text = " Buff: " + str(get_self_buff().value) + "-" + str(get_self_buff().max_value)
	$VBoxContainer/SelfBar_Jog/SelfScore.text = " Jog: " + str(get_self_jog().value) + "-" + str(get_self_jog().max_value)
	$VBoxContainer/SelfBar_Beat/SelfScore.text = " Beat: " + str(get_self_beat().value) + "-" + str(get_self_beat().max_value)

func _on_playerLose(score, player_name_upper):
	var nodeLocation = "VBoxContainer/SelfBar_%s"%[player_name_upper]
	get_node(nodeLocation).value = player1.self_score
	var childLocation = "VBoxContainer/SelfBar_%s/Lose%s"%[player_name_upper, player_name_upper]
	get_node(childLocation).text = str(score)
	var anim_name = "Lose%s"%[player_name_upper]
	$Control/SelfAnimationPlayer.play(anim_name)
	
	update_score($VBoxContainer/SelfBar_Surp, player1.self_score)
	update_score($VBoxContainer/SelfBar_Buff, player2.self_score)
	update_score($VBoxContainer/SelfBar_Jog, player3.self_score)
	update_score($VBoxContainer/SelfBar_Beat, player4.self_score)
	$VBoxContainer/SelfBar_Surp/SelfScore.text = " Surp: " + str(get_self_surp().value) + "-" + str(get_self_surp().max_value)
	$VBoxContainer/SelfBar_Buff/SelfScore.text = " Buff: " + str(get_self_buff().value) + "-" + str(get_self_buff().max_value)
	$VBoxContainer/SelfBar_Jog/SelfScore.text = " Jog: " + str(get_self_jog().value) + "-" + str(get_self_jog().max_value)
	$VBoxContainer/SelfBar_Beat/SelfScore.text = " Beat: " + str(get_self_beat().value) + "-" + str(get_self_beat().max_value)


#func anim_add_surp(score):
#	var new_string = "+" + str(score)
#	$VBoxContainer/SelfBar_Surp/AddSurp.text = str("+") + str(score)
#	$Control/SelfAnimationPlayer.play("AddSurp")




func popup_postChoice_self():
	postChoice_popup_anim.play_backwards("PopupPostChoice")
	if postChoice_popup_sprite.get_node("Surp").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_SELF").format(\
			{var1=get_self_surp().value})
	elif postChoice_popup_sprite.get_node("Buff").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_SELF").format(\
			{var1=get_self_buff().value})
	elif postChoice_popup_sprite.get_node("Jog").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_SELF").format(\
			{var1=get_self_jog().value})
	elif postChoice_popup_sprite.get_node("Beat").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_SELF").format(\
			{var1=get_self_beat().value})

func popup_postChoice_society():
	postChoice_popup_anim.play_backwards("PopupPostChoice")
	if postChoice_popup_sprite.get_node("Surp").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_SOCIETY").format(\
			{var1=get_self_surp().value})
	elif postChoice_popup_sprite.get_node("Buff").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_SOCIETY").format(\
			{var1=get_self_buff().value})
	elif postChoice_popup_sprite.get_node("Jog").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_SOCIETY").format(\
			{var1=get_self_jog().value})
	elif postChoice_popup_sprite.get_node("Beat").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_SOCIETY").format(\
			{var1=get_self_beat().value})

func popup_postChoice_sustainability():
	postChoice_popup_anim.play_backwards("PopupPostChoice")
	if postChoice_popup_sprite.get_node("Surp").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_SUSTAINABILITY").format(\
			{var1=get_self_surp().value})
	elif postChoice_popup_sprite.get_node("Buff").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_SUSTAINABILITY").format(\
			{var1=get_self_buff().value})
	elif postChoice_popup_sprite.get_node("Jog").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_SUSTAINABILITY").format(\
			{var1=get_self_jog().value})
	elif postChoice_popup_sprite.get_node("Beat").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_SUSTAINABILITY").format(\
			{var1=get_self_beat().value})

func popup_postChoice_nothing():
	postChoice_popup_anim.play_backwards("PopupPostChoice")
	if postChoice_popup_sprite.get_node("Surp").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_NOTHING").format(\
			{var1=get_self_surp().value})
	elif postChoice_popup_sprite.get_node("Buff").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_NOTHING").format(\
			{var1=get_self_buff().value})
	elif postChoice_popup_sprite.get_node("Jog").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_NOTHING").format(\
			{var1=get_self_jog().value})
	elif postChoice_popup_sprite.get_node("Beat").visible == true:
		postChoice_popup_text.bbcode_text = tr("CHOICE_NOTHING").format(\
			{var1=get_self_beat().value})


func _on_PostChoicePopup_NextButton_pressed():
	postChoice_popup_anim.play("PopupPostChoice")
	emit_signal("turnOver")


