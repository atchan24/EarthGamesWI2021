extends Node


var sprite
var text
var popup_anim

# sprite for the 21 objects that appear (based on board space)
var sprite_Arts = load("res://Assets/Demo Art/Palette.png")
var sprite_Community = load("res://Assets/Demo Art/Meeting_Group.png")
var sprite_Death = load("res://Assets/Demo Art/Grave_Stone.png")
var sprite_Decolonization = load("res://Assets/Demo Art/Protest_Land.png")
var sprite_Education = load("res://Assets/Demo Art/School.png")
var sprite_Energy = load("res://Assets/Demo Art/WindTurbine.PNG")
var sprite_Environment = load("res://Assets/Ashley_Art/Tree.PNG")
var sprite_Equity = load("res://Assets/Art/IMG_0747.PNG")
var sprite_Food = load("res://Assets/Demo Art/BoxOfFruit.png")
var sprite_Health = load("res://Assets/Demo Art/MedicalTent.png")
var sprite_Housing = load("res://Assets/Demo Art/House.PNG")
var sprite_Justice = load("res://Assets/Demo Art/CityHall.png")
var sprite_JustMigration = load("res://Assets/Wave 1/ParakeetWhite.png")
var sprite_MutualAid = load("res://Assets/Demo Art/Flag_Money.png")
var sprite_Nature = load("res://Assets/Demo Art/FlowerYellow.png")
var sprite_Recreation = load("res://Assets/Demo Art/Note.png")
var sprite_Resources = load("res://Assets/Demo Art/DoubleSolarPanels.PNG")
var sprite_Storytelling = load("res://Assets/Demo Art/Library.png")
var sprite_Transport = load("res://Assets/Ashley_Art/Bike.png")
var sprite_Truth = load("res://Assets/Demo Art/LawBuilding.png")
var sprite_Work = load("res://Assets/Demo Art/Laptop.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("Control/TextureRect/Sprite")
	text = get_node("Control/TextureRect/RichTextLabel")
	popup_anim = get_node("Control/AnimationPlayer")


# sets the sprite and text for that category (Action card)
func reset_popup(category):
	print("space category: ", category)
	
	if "Justice" in category:
		sprite.texture = sprite_Justice
		text.bbcode_text = tr("ACTION_CARD_01")
	elif "Equity" in category:
		sprite.texture = sprite_Equity
		text.bbcode_text = tr("ACTION_CARD_02")
	elif "Health" in category:
		sprite.texture = sprite_Health
		text.bbcode_text = tr("ACTION_CARD_03")
	elif "Education" in category:
		sprite.texture = sprite_Education
		text.bbcode_text = tr("ACTION_CARD_04")
	elif "Housing" in category:
		sprite.texture = sprite_Housing
		text.bbcode_text = tr("ACTION_CARD_05")
	elif "Food" in category:
		sprite.texture = sprite_Food
		text.bbcode_text = tr("ACTION_CARD_06")
	elif "Community" in category:
		sprite.texture = sprite_Community
		text.bbcode_text = tr("ACTION_CARD_07")
	elif "Work" in category:
		sprite.texture = sprite_Work
		text.bbcode_text = tr("ACTION_CARD_08")
	elif "Energy" in category:
		sprite.texture = sprite_Energy
		text.bbcode_text = tr("ACTION_CARD_09")
	elif "Mutual" in category:
		sprite.texture = sprite_MutualAid
		text.bbcode_text = tr("ACTION_CARD_10")
	elif "Migration" in category:
		sprite.texture = sprite_JustMigration
		text.bbcode_text = tr("ACTION_CARD_11")
	elif "Nature" in category:
		sprite.texture = sprite_Nature
		text.bbcode_text = tr("ACTION_CARD_12")
	elif "Recreation" in category:
		sprite.texture = sprite_Recreation
		text.bbcode_text = tr("ACTION_CARD_13")
	elif "Environment" in category:
		sprite.texture = sprite_Environment
		text.bbcode_text = tr("ACTION_CARD_14")
	elif "Decolonization" in category:
		sprite.texture = sprite_Decolonization
		text.bbcode_text = tr("ACTION_CARD_15")
	elif "Storytelling" in category:
		sprite.texture = sprite_Storytelling
		text.bbcode_text = tr("ACTION_CARD_16")
	elif "Transport" in category:
		sprite.texture = sprite_Transport
		text.bbcode_text = tr("ACTION_CARD_17")
	elif "Arts" in category:
		sprite.texture = sprite_Arts
		text.bbcode_text = tr("ACTION_CARD_18")
	elif "Resources" in category:
		sprite.texture = sprite_Resources
		text.bbcode_text = tr("ACTION_CARD_19")
	elif "Truth" in category:
		sprite.texture = sprite_Truth
		text.bbcode_text = tr("ACTION_CARD_20")
	elif "Death" in category:
		sprite.texture = sprite_Death
		text.bbcode_text = tr("ACTION_CARD_21")
	
	
	

func popup():
	popup_anim.play("popup_choiceObject")

