extends Control


var sprite
var sprite_list
var text
var popup_anim
var sticker_book
var sticker_book_anim
var stickers

onready var glossary = get_node("Backpack/Glossary")

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
	sprite_list = [
		sprite_Justice, sprite_Equity, sprite_Health, sprite_Education, sprite_Housing, \
		sprite_Food, sprite_Community, sprite_Work, sprite_Energy, sprite_MutualAid, \
		sprite_JustMigration, sprite_Nature, sprite_Recreation, sprite_Environment, \
		sprite_Decolonization, sprite_Storytelling, sprite_Transport,\
		sprite_Arts, sprite_Resources, sprite_Truth,   sprite_Death,
		]
	text = get_node("Control/TextureRect/RichTextLabel")
	popup_anim = get_node("Control/AnimationPlayer")
	sticker_book = get_node("Backpack/StickerBook")
	sticker_book_anim = get_node("Backpack/StickerBook/AnimationPlayer")
	stickers = get_node("Backpack/StickerBook/TextureRect/Stickers")
	
	add_all_stickers()


func add_all_stickers():
	var n = 0
	for sticker in stickers.get_children():
		sticker.texture = sprite_list[n]
		sticker.modulate = Color(0.4, 0.4, 0.4)
		n += 1
	pass



# sets the sprite and text for that category (Action card)
# modulates a sticker once the coresponding space has been landed on
func reset_popup(category):
	print("space category: ", category)

	
	if "Justice" in category:
		sprite.texture = sprite_Justice
		text.bbcode_text = tr("ACTION_CARD_01")
		stickers.get_child(0).modulate = Color(1, 1, 1)
	elif "Equity" in category:
		sprite.texture = sprite_Equity
		text.bbcode_text = tr("ACTION_CARD_02")
		stickers.get_child(1).modulate = Color(1, 1, 1)
	elif "Health" in category:
		sprite.texture = sprite_Health
		text.bbcode_text = tr("ACTION_CARD_03")
		stickers.get_child(2).modulate = Color(1, 1, 1)
	elif "Education" in category:
		sprite.texture = sprite_Education
		text.bbcode_text = tr("ACTION_CARD_04")
		stickers.get_child(3).modulate = Color(1, 1, 1)
	elif "Housing" in category:
		sprite.texture = sprite_Housing
		text.bbcode_text = tr("ACTION_CARD_05")
		stickers.get_child(4).modulate = Color(1, 1, 1)
	elif "Food" in category:
		sprite.texture = sprite_Food
		text.bbcode_text = tr("ACTION_CARD_06")
		stickers.get_child(5).modulate = Color(1, 1, 1)
	elif "Community" in category:
		sprite.texture = sprite_Community
		text.bbcode_text = tr("ACTION_CARD_07")
		stickers.get_child(6).modulate = Color(1, 1, 1)
	elif "Work" in category:
		sprite.texture = sprite_Work
		text.bbcode_text = tr("ACTION_CARD_08")
		stickers.get_child(7).modulate = Color(1, 1, 1)
	elif "Energy" in category:
		sprite.texture = sprite_Energy
		text.bbcode_text = tr("ACTION_CARD_09")
		stickers.get_child(8).modulate = Color(1, 1, 1)
	elif "Mutual" in category:
		sprite.texture = sprite_MutualAid
		text.bbcode_text = tr("ACTION_CARD_10")
		stickers.get_child(9).modulate = Color(1, 1, 1)
	elif "Migration" in category:
		sprite.texture = sprite_JustMigration
		text.bbcode_text = tr("ACTION_CARD_11")
		stickers.get_child(10).modulate = Color(1, 1, 1)
	elif "Nature" in category:
		sprite.texture = sprite_Nature
		text.bbcode_text = tr("ACTION_CARD_12")
		stickers.get_child(11).modulate = Color(1, 1, 1)
	elif "Recreation" in category:
		sprite.texture = sprite_Recreation
		text.bbcode_text = tr("ACTION_CARD_13")
		stickers.get_child(12).modulate = Color(1, 1, 1)
	elif "Environment" in category:
		sprite.texture = sprite_Environment
		text.bbcode_text = tr("ACTION_CARD_14")
		stickers.get_child(13).modulate = Color(1, 1, 1)
	elif "Decolonization" in category:
		sprite.texture = sprite_Decolonization
		text.bbcode_text = tr("ACTION_CARD_15")
		stickers.get_child(14).modulate = Color(1, 1, 1)
	elif "Storytelling" in category:
		sprite.texture = sprite_Storytelling
		text.bbcode_text = tr("ACTION_CARD_16")
		stickers.get_child(15).modulate = Color(1, 1, 1)
	elif "Transport" in category:
		sprite.texture = sprite_Transport
		text.bbcode_text = tr("ACTION_CARD_17")
		stickers.get_child(16).modulate = Color(1, 1, 1)
	elif "Arts" in category:
		sprite.texture = sprite_Arts
		text.bbcode_text = tr("ACTION_CARD_18")
		stickers.get_child(17).modulate = Color(1, 1, 1)
	elif "Resources" in category:
		sprite.texture = sprite_Resources
		text.bbcode_text = tr("ACTION_CARD_19")
		stickers.get_child(18).modulate = Color(1, 1, 1)
	elif "Truth" in category:
		sprite.texture = sprite_Truth
		text.bbcode_text = tr("ACTION_CARD_20")
		stickers.get_child(19).modulate = Color(1, 1, 1)
	elif "Death" in category:
		sprite.texture = sprite_Death
		text.bbcode_text = tr("ACTION_CARD_21")
		stickers.get_child(20).modulate = Color(1, 1, 1)
	
	
	

func popup():
	popup_anim.play("popup_choiceObject")


func _on_Backpack_Open_pressed():
	sticker_book_anim.play("popupBackpack")

func _on_BackpackClose_pressed():
	sticker_book_anim.play_backwards("popupBackpack")


func _on_MiniMap_pressed():
	sticker_book_anim.play("popupStickerBook")
	#glossary.hide()


func _on_MiniMap_Close_pressed():
	sticker_book_anim.play_backwards("popupStickerBook")	




func _on_Glossary_pressed():
	glossary.show()
