extends Control


signal turnOver

onready var main = get_parent().get_parent()

onready var spaces = main.get_node("Spaces")

onready var players = main.get_node("Players")
onready var player1 = players.get_node("Player1")
onready var player2 = players.get_node("Player2")
onready var player3 = players.get_node("Player3")
onready var player4 = players.get_node("Player4")

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
	
	player1.connect("player1add", self, "anim_add_surp")
	player2.connect("player2add", self, "anim_add_buff")
	player3.connect("player3add", self, "anim_add_jog")
	player4.connect("player4add", self, "anim_add_beat")
	
	player1.connect("player1lose", self, "anim_lose_surp")
	player2.connect("player2lose", self, "anim_lose_buff")
	player3.connect("player3lose", self, "anim_lose_jog")
	player4.connect("player4lose", self, "anim_lose_beat")
	
	self_bar_buff.modulate = Color(0.75, 0.75, 0.75)
	self_bar_jog.modulate = Color(0.75, 0.75, 0.75)
	self_bar_beat.modulate = Color(0.75, 0.75, 0.75)


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
#	self_bar_surp.rect_scale = Vector2(1.2, 1.2)
#	self_bar_buff.rect_scale = Vector2(1.0, 1.0)
#	self_bar_jog.rect_scale = Vector2(1.0, 1.0)
#	self_bar_beat.rect_scale = Vector2(1.0, 1.0)
	self_bar_surp.modulate = Color(1, 1, 1)
	self_bar_buff.modulate = Color(0.75, 0.75, 0.75)
	self_bar_jog.modulate = Color(0.75, 0.75, 0.75)
	self_bar_beat.modulate = Color(0.75, 0.75, 0.75)
	postChoice_popup_sprite.get_node("Surp").visible = true
	postChoice_popup_sprite.get_node("Buff").visible = false
	postChoice_popup_sprite.get_node("Jog").visible = false
	postChoice_popup_sprite.get_node("Beat").visible = false
	update_turn_label()
func handle_P2_active():
	self_bar_surp.modulate = Color(0.75, 0.75, 0.75)
	self_bar_buff.modulate = Color(1, 1, 1)
	self_bar_jog.modulate = Color(0.75, 0.75, 0.75)
	self_bar_beat.modulate = Color(0.75, 0.75, 0.75)
	postChoice_popup_sprite.get_node("Surp").visible = false
	postChoice_popup_sprite.get_node("Buff").visible = true
	postChoice_popup_sprite.get_node("Jog").visible = false
	postChoice_popup_sprite.get_node("Beat").visible = false
	update_turn_label()
func handle_P3_active():
	self_bar_surp.modulate = Color(0.75, 0.75, 0.75)
	self_bar_buff.modulate = Color(0.75, 0.75, 0.75)
	self_bar_jog.modulate = Color(1, 1, 1)
	self_bar_beat.modulate = Color(0.75, 0.75, 0.75)
	postChoice_popup_sprite.get_node("Surp").visible = false
	postChoice_popup_sprite.get_node("Buff").visible = false
	postChoice_popup_sprite.get_node("Jog").visible = true
	postChoice_popup_sprite.get_node("Beat").visible = false
	update_turn_label()
func handle_P4_active():
	self_bar_surp.modulate = Color(0.75, 0.75, 0.75)
	self_bar_buff.modulate = Color(0.75, 0.75, 0.75)
	self_bar_jog.modulate = Color(0.75, 0.75, 0.75)
	self_bar_beat.modulate = Color(1, 1, 1)
	postChoice_popup_sprite.get_node("Surp").visible = false
	postChoice_popup_sprite.get_node("Buff").visible = false
	postChoice_popup_sprite.get_node("Jog").visible = false
	postChoice_popup_sprite.get_node("Beat").visible = true
	update_turn_label()


func update_turn_label():
	var turn = spaces._round
	turn += 1
	$Label.text = "Turn " + str(turn)


# ANIMATIONS
func anim_add_society():
	$Control/AnimationPlayer.play("AddSociety")

func anim_add_sustainability():
	$Control/AnimationPlayer.play("AddSustainability")

func anim_add_surp():
	$Control/SelfAnimationPlayer.play("AddSurp")
func anim_add_buff():
	$Control/SelfAnimationPlayer.play("AddBuff")
func anim_add_jog():
	$Control/SelfAnimationPlayer.play("AddJog")
func anim_add_beat():
	$Control/SelfAnimationPlayer.play("AddBeat")
	
func anim_lose_surp():
	$Control/SelfAnimationPlayer.play("LoseSurp")
func anim_lose_buff():
	$Control/SelfAnimationPlayer.play("LoseBuff")
func anim_lose_jog():
	$Control/SelfAnimationPlayer.play("LoseJog")
func anim_lose_beat():
	$Control/SelfAnimationPlayer.play("LoseBeat")




func _on_glossary_pressed():
	pass # Replace with function body.




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
