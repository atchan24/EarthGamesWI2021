extends Control


onready var popup_anim = get_node("AnimationPlayer")

onready var main = get_parent().get_parent().get_parent()

onready var spaces = main.get_node("Spaces")

onready var players = main.get_node("Players")
onready var player1 = players.get_node("Player1")
onready var player2 = players.get_node("Player2")
onready var player3 = players.get_node("Player3")
onready var player4 = players.get_node("Player4")



const velocity = 10

func _ready():
	popup_anim.play("popupGlossary")
	spaces = get_node("/root/Main/Spaces").get_children()
#	set_process(false)
	pass # Replace with function body.


func _on_invite_pressed():
	popup_anim.play_backwards("popupGlossary")


func _on_ClosedInvite_pressed():
	popup_anim.play("popupGlossary")

func summon(player):
	popup_anim.play("popupGlossary")
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
	spaces[target].bonus_value += 10
	player.update_values(score_change)
	player.call_card = false
	player.moving = true
	player.roll = target
	
func _on_invite_buff_pressed():
	summon(player2)
	
func _on_invite_surp_pressed():
	summon(player1)
	
func _on_invite_job_pressed():
	summon(player3)

func _on_invite_beat_pressed():
	summon(player4)
