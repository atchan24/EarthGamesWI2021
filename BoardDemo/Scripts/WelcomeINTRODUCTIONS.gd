extends Node2D


var _d
var destination : String = "res://Scenes/Main.tscn"


onready var richText = get_node("Control/TextBubble/RichTextLabel")
onready var nextButton = get_node("Control/TextBubble/NextButton")
onready var popup_anim = get_node("Control/TextBubble/AnimationPlayer")

var dialog = ["INTRO", "INTRO_SERP", "INTRO_BUFF", "INTRO_JOG", "INTRO_BEAT", "OUTRO"]
var page = 0
var next_pressed = 0

var loading = false

# Called when the node enters the scene tree for the first time.
func _ready():
	richText.set_bbcode(tr(dialog[page]))
	richText.set_visible_characters(0)
	nextButton.disabled = true
	popup_anim.play("PopupText")
	yield(popup_anim, "animation_finished")
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if richText.get_visible_characters() >= richText.get_total_character_count():
		nextButton.disabled = false
	else:
		nextButton.disabled = true
	
	if loading == true:
		nextButton.disabled = true


func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		
		if richText.get_visible_characters() < richText.get_total_character_count():
			$Timer.stop()
			richText.set_visible_characters(richText.get_total_character_count())


func _on_Timer_timeout():
	richText.set_visible_characters(richText.get_visible_characters() + 1 )


func _on_NextButton_pressed():
	
	next_pressed += 1
	$Audio/ButtonPress.play()
	
	if next_pressed == 1:
		richText.rect_position.x = 186
		richText.rect_position.y = 80
		richText.rect_size.x = 750
		richText.rect_size.y = 202
		$Frgnd/Surp.visible = true
	elif next_pressed == 2:
		$Frgnd/Surp.visible = false
		$Frgnd/Buff.visible = true
	elif next_pressed == 3:
		$Frgnd/Buff.visible = false
		$Frgnd/Jog.visible = true
	elif next_pressed == 4:
		$Frgnd/Jog.visible = false
		$Frgnd/Beat.visible = true
	else:
		$Frgnd/Beat.visible = false
		richText.rect_position.y = 140
		richText.rect_position.x = 100
	
	turn_page()


func turn_page():
	if page < dialog.size()-1:
		print("next page")
		page += 1
		richText.set_bbcode(tr(dialog[page]))
		richText.set_visible_characters(0)
		$Timer.start()
	elif page == dialog.size()-1:
		loading = true
		popup_anim.play_backwards("PopupText")
		yield(popup_anim, "animation_finished")
		_d = get_node("/root/Global").goto_scene(destination)

