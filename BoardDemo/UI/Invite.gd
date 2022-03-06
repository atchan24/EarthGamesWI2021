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

onready var buff_distance = get_node("TextureRect/buff_costs/distance")
onready var buff_cost = get_node("TextureRect/buff_costs/self_cost")

onready var jog_distance = get_node("TextureRect/jog_costs/distance")
onready var jog_cost = get_node("TextureRect/jog_costs/self_cost")

onready var beat_distance = get_node("TextureRect/beat_costs/distance")
onready var beat_cost = get_node("TextureRect/beat_costs/self_cost")

var manager = null

var choice = null

const velocity = 10

func _ready():
	popup_anim.play("inviteMenu")
	spaces = get_node("/root/Main/Spaces").get_children()
	manager = get_node("/root/Main/Spaces")
#	update_invite_values()
#	set_process(false)

func _process(delta):
	pass

func _on_invite_pressed():
	popup_anim.play_backwards("inviteMenu")
#	update_invite_values()


func _on_ClosedInvite_pressed():
	popup_anim.play("inviteMenu")

func summon(player):
#	player.players_invited += 1
	Global.players_invited += 1
	popup_anim.play("inviteMenu")
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

	surp_distance.text = str(active_player.current - player1.current) + " spaces away, "
	surp_cost.text = "-" + str((active_player.current - player1.current) * int(Global.movement_cost)) + " self points"
	
	buff_distance.text = str(active_player.current - player2.current) + " spaces away, "
	buff_cost.text = "-" + str((active_player.current - player2.current) * int(Global.movement_cost)) + " self points"
	
	jog_distance.text = str(active_player.current - player3.current) + " spaces away, "
	jog_cost.text = "-" + str((active_player.current - player3.current) * int(Global.movement_cost)) + " self points"
	
	beat_distance.text = str(active_player.current - player4.current) + " spaces away, "
	beat_cost.text = "-" + str((active_player.current - player4.current) * int(Global.movement_cost)) + " self points"

func _on_invite_buff_pressed():
	summon(player2)
	find_active_player().update_values(-5)
	manager.handle_events_demo(choice, true)
	
func _on_invite_surp_pressed():
	summon(player1)
	find_active_player().update_values(-5)
	manager.handle_events_demo(choice, true)
	
func _on_invite_job_pressed():
	summon(player3)
	find_active_player().update_values(-5)
	manager.handle_events_demo(choice, true)

func _on_invite_beat_pressed():
	summon(player4)
	find_active_player().update_values(-5)
	manager.handle_events_demo(choice, true)


func _on_go_alone_pressed():
	find_active_player().update_values(-5)
	manager.handle_events_demo(choice, true)
