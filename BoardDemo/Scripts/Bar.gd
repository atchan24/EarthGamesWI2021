extends Control

onready var main = get_parent().get_parent()

onready var player1 = main.get_node("Players/Player1")
onready var player2 = main.get_node("Players/Player2")
onready var player3 = main.get_node("Players/Player3")
onready var player4 = main.get_node("Players/Player4")

onready var self_bar_serp = get_node("VBoxContainer/SelfBar_Surp")
onready var self_bar_buff = get_node("VBoxContainer/SelfBar_Buff")
onready var self_bar_jog = get_node("VBoxContainer/SelfBar_Jog")
onready var self_bar_beat = get_node("VBoxContainer/SelfBar_Beat")
onready var society_bar = get_node("Control/SocietyBar")
onready var sustain_bar = get_node("Control/SustainBar")

func _ready():
	player1.connect("player1add", self, "anim_add_surp")
	player2.connect("player2add", self, "anim_add_buff")
	player3.connect("player3add", self, "anim_add_jog")
	player4.connect("player4add", self, "anim_add_beat")
	player1.connect("player1lose", self, "anim_lose_surp")
	player2.connect("player2lose", self, "anim_lose_buff")
	player3.connect("player3lose", self, "anim_lose_jog")
	player4.connect("player4lose", self, "anim_lose_beat")


func update_score(node, score):
	node.value = score

func get_counter():
	return get_node("RollsCounter")	
	
func get_self_serp():
	return self_bar_serp

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
