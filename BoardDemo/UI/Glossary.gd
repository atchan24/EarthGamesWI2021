extends Control


onready var popup_anim = get_node("AnimationPlayer")



func _ready():
	pass # Replace with function body.


func _on_glossary_pressed():
	popup_anim.play_backwards("popupGlossary")


func _on_CloseGlossary_pressed():
	popup_anim.play("popupGlossary")
