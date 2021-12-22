extends Node2D

var _d
var destination : String = "res://Scenes/Main.tscn"


onready var richText = get_node("Control/TextBubble/RichTextLabel")
onready var nextButton = get_node("Control/TextBubble/NextButton")
onready var popup_anim = get_node("Control/TextBubble/AnimationPlayer")

var dialog = ["WELCOME_01", "WELCOME_02", "WELCOME_03", "WELCOME_04",]
var page = 0


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
	$Frgnd.position += Vector2(0.25, 0)
	if richText.get_visible_characters() >= richText.get_total_character_count():
		nextButton.disabled = false
	else:
		nextButton.disabled = true


func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		
		if richText.get_visible_characters() < richText.get_total_character_count():
			$Timer.stop()
			richText.set_visible_characters(richText.get_total_character_count())


func _on_Timer_timeout():
	richText.set_visible_characters(richText.get_visible_characters() + 1 )


func _on_NextButton_pressed():
	if page < dialog.size()-1:
		print("next page")
		page += 1
		richText.set_bbcode(tr(dialog[page]))
		richText.set_visible_characters(0)
		$Timer.start()
	else:
		popup_anim.play_backwards("PopupText")
		yield(popup_anim, "animation_finished")
		_d = get_node("/root/Global").goto_scene(destination)


