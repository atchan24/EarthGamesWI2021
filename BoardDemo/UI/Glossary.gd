extends Control


onready var popup_anim = get_node("AnimationPlayer")
onready var popup_anim2 = get_parent().get_node("Instructions/AnimationPlayer")

onready var glossary_text = get_node("TextureRect/RichTextLabel")
onready var instructions_text = get_parent().get_node("Instructions/TextureRect/RichTextLabel")



func _ready():
	instructions_text.bbcode_text = \
		tr("WELCOME_03") + tr("WELCOME_04") + tr("WELCOME_05")
		
	glossary_text.bbcode_text = \
		tr("GLOSSARY_01") + tr("GLOSSARY_02") + tr("GLOSSARY_03") \
		+ tr("ACTION_CARD_01") + tr("ACTION_CARD_02") + tr("ACTION_CARD_03") \
		+ tr("ACTION_CARD_04") + tr("ACTION_CARD_05") + tr("ACTION_CARD_06") \
		+ tr("ACTION_CARD_07") + tr("ACTION_CARD_08") + tr("ACTION_CARD_09") \
		+ tr("ACTION_CARD_10") + tr("ACTION_CARD_11") + tr("ACTION_CARD_12") \
		+ tr("ACTION_CARD_13") + tr("ACTION_CARD_14") + tr("ACTION_CARD_15") \
		+ tr("ACTION_CARD_16") + tr("ACTION_CARD_17") + tr("ACTION_CARD_18") \
		+ tr("ACTION_CARD_19") + tr("ACTION_CARD_20") + tr("ACTION_CARD_21")







func _on_Glossary_pressed():
	popup_anim.play("popupGlossary")
func _on_Instructions_pressed():
	popup_anim2.play("popoupInstructions")

func _on_CloseGlossary_pressed():
	popup_anim.play_backwards("popupGlossary")
func _on_CloseInstructions_pressed():
	popup_anim2.play_backwards("popoupInstructions")
