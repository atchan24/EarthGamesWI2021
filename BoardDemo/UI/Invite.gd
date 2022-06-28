extends Control

signal player_invited

onready var popup_anim = get_node("AnimationPlayer")

onready var main = get_parent().get_parent().get_parent()

onready var spaces = main.get_node("Spaces")

onready var players = main.get_node("Players")
onready var player1 = players.get_node("Player1")
onready var player2 = players.get_node("Player2")
onready var player3 = players.get_node("Player3")
onready var player4 = players.get_node("Player4")

onready var surp_distance = get_node("TextureRect/surp_costs/distance")
onready var surp_cost = get_node("TextureRect/surp_costs/self_cost")
onready var surp_button = get_node("TextureRect/invite_surp")
onready var surp_button_label = get_node("TextureRect/invite_surp/Label")

onready var buff_distance = get_node("TextureRect/buff_costs/distance")
onready var buff_cost = get_node("TextureRect/buff_costs/self_cost")
onready var buff_button = get_node("TextureRect/invite_buff")
onready var buff_button_label = get_node("TextureRect/invite_buff/Label")

onready var jog_distance = get_node("TextureRect/jog_costs/distance")
onready var jog_cost = get_node("TextureRect/jog_costs/self_cost")
onready var jog_button = get_node("TextureRect/invite_jog")
onready var jog_button_label = get_node("TextureRect/invite_jog/Label")

onready var beat_distance = get_node("TextureRect/beat_costs/distance")
onready var beat_cost = get_node("TextureRect/beat_costs/self_cost")
onready var beat_button = get_node("TextureRect/invite_beat")
onready var beat_button_label = get_node("TextureRect/invite_beat/Label")

var manager = null
var top_bar = null
var self_bars_anim_player = null
var choice = null

var movement_cost_p1 = 0
var movement_cost_p2 = 0
var movement_cost_p3 = 0
var movement_cost_p4 = 0

const velocity = 10

func _ready():
#	popup_anim.play("inviteMenu")
	spaces = get_node("/root/Main/Spaces").get_children()
	manager = get_node("/root/Main/Spaces")
	top_bar = get_node("/root/Main/GUI/TopBar")
	self_bars_anim_player = get_node("/root/Main/GUI/TopBar/Control/SelfAnimationPlayer")
#	update_invite_values()
#	set_process(false)

#func _process(delta):
#	pass

#func _on_invite_pressed():
#	popup_anim.play_backwards("inviteMenu")
##	update_invite_values()


func _on_ClosedInvite_pressed():
	popup_anim.play("inviteMenu")

func summon(player):
#	player.players_invited += 1
	Global.players_invited += 1
#	popup_anim.play("inviteMenu")
	var target
	if player1.active == true:
		target = player1.current - player.current
	if player2.active == true:
		target = player2.current - player.current
	if player3.active == true:
		target = player3.current - player.current
	if player4.active == true:
		target = player4.current - player.current
	var score_change = abs(target * int(Global.movement_cost)) * -1
#	spaces[target].bonus_value += 10
	player.call_card = false
	player.moving = true
	player.roll = target
	player.update_values(score_change)
#	spaces[player.current].call_manager(player, player.players_invited)

func find_active_player():
	if player1.active == true:
		return player1
	if player2.active == true:
		return player2
	if player3.active == true:
		return player3
	if player4.active == true:
		return player4

func update_invite_values():
	var active_player = find_active_player()
	var active_player_distance = get_node("TextureRect/%s_costs/distance"%active_player.player_name_lower)
	var active_player_cost = get_node("TextureRect/%s_costs/self_cost"%active_player.player_name_lower)
	var active_player_button = get_node("TextureRect/invite_%s"%active_player.player_name_lower)
	var active_player_button_label = get_node("TextureRect/invite_%s/Label"%active_player.player_name_lower)
#	print("active player: " + str(active_player.player_name_lower))
##	print("%s_distance"%active_player.player_name_lower)
#	print(get_node("TextureRect/%s_costs/distance"%active_player.player_name_lower).text)
	
	if active_player.current > player1.current:
		surp_button.visible = true
		surp_distance.text = str(active_player.current - player1.current) + " spaces away, "
		movement_cost_p1 = (active_player.current - player1.current) * int(Global.movement_cost)
		surp_cost.text = "-" + str(movement_cost_p1) + " self points"
		surp_button_label.text = "Invite Surp!"
		
		if movement_cost_p1 > player1.self_score:
			surp_button.visible = false
			surp_distance.text = "Surp needs " + str(movement_cost_p1) + " energy to move " + str(active_player.current - player1.current) + " squares"
			surp_cost.text = ""
	else:
		surp_button.visible = false
		surp_distance.text = "Can't invite someone in front of you!"
		surp_cost.text = ""
	
	if active_player.current > player2.current:
		buff_button.visible = true
		buff_distance.text = str(active_player.current - player2.current) + " spaces away, "
		movement_cost_p2 = (active_player.current - player2.current) * int(Global.movement_cost)
		buff_cost.text = "-" + str(movement_cost_p2) + " self points"
		buff_button_label.text = "Invite Buff!"
		
		if movement_cost_p2 > player2.self_score:
			buff_button.visible = false
			buff_distance.text = "Buff needs " + str(movement_cost_p2) + " energy to move " + str(active_player.current - player2.current) + " squares"
			buff_cost.text = ""
	else:
		buff_button.visible = false
		buff_distance.text = "Can't invite someone in front of you!"
		buff_cost.text = ""
	
	if active_player.current > player3.current:
		jog_button.visible = true
		jog_distance.text = str(active_player.current - player3.current) + " spaces away, "
		movement_cost_p3 = (active_player.current - player3.current) * int(Global.movement_cost)
		jog_cost.text = "-" + str(movement_cost_p3) + " self points"
		jog_button_label.text = "Invite Jog!"
		
		if movement_cost_p3 > player3.self_score:
			jog_button.visible = false
			jog_distance.text = "Jog needs " + str(movement_cost_p3) + " energy to move " + str(active_player.current - player3.current) + " squares"
			jog_cost.text = ""
	else:
		jog_button.visible = false
		jog_distance.text = "Can't invite someone in front of you!"
		jog_cost.text = ""
	
	if active_player.current > player4.current:
		beat_button.visible = true
		beat_distance.text = str(active_player.current - player4.current) + " spaces away, "
		movement_cost_p4 = (active_player.current - player4.current) * int(Global.movement_cost)
		beat_cost.text = "-" + str(movement_cost_p4) + " self points"
		beat_button_label.text = "Invite Beat!"
		
		if movement_cost_p4 > player4.self_score:
			beat_button.visible = false
			beat_distance.text = "Beat needs " + str(movement_cost_p4) + " energy to move " + str(active_player.current - player4.current) + " squares"
			beat_cost.text = ""
	else:
		beat_button.visible = false
		beat_distance.text = "Can't invite someone in front of you!"
		beat_cost.text = ""
	
	active_player_distance.text = ""
	active_player_cost.text = ""
	active_player_button.visible = true
	active_player_button_label.text = "Go Alone!"

func _on_invite_buff_pressed():
	var active_player = find_active_player()
	if active_player.player_name_lower != player2.player_name_lower:
		summon(player2)
	active_player.update_values(-5)
	manager.handle_events_demo(choice, true)
	yield(self_bars_anim_player, "animation_finished")
	top_bar._on_playerLose(-movement_cost_p2, "Buff")
	#reposition_players_on_minimap(player, x)
	
func _on_invite_surp_pressed():
	var active_player = find_active_player()
	if active_player.player_name_lower != player1.player_name_lower:
		summon(player1)
	active_player.update_values(-5)
	manager.handle_events_demo(choice, true)
	yield(self_bars_anim_player, "animation_finished")
	top_bar._on_playerLose(-movement_cost_p1, "Surp")
	
func _on_invite_job_pressed():
	var active_player = find_active_player()
	if active_player.player_name_lower != player3.player_name_lower:
		summon(player3)
	find_active_player().update_values(-5)
	manager.handle_events_demo(choice, true)
	yield(self_bars_anim_player, "animation_finished")
	top_bar._on_playerLose(-movement_cost_p3, "Jog")

func _on_invite_beat_pressed():
	var active_player = find_active_player()
	if active_player.player_name_lower != player4.player_name_lower:
		summon(player4)
	find_active_player().update_values(-5)
	manager.handle_events_demo(choice, true)
	yield(self_bars_anim_player, "animation_finished")
	top_bar._on_playerLose(-movement_cost_p4, "Beat")


func _on_go_alone_pressed():
	find_active_player().update_values(-5)
	manager.handle_events_demo(choice, true)
