extends Control


var sprite
var sprite_list = []
var choice_text     # popup action card choice
var popup_anim      # popup action card choice
var popup_anim_glossary
var popup_anim_instructions
var sticker_book
var sticker_book_anim  # backpack
var stickers
var spaces_position_list = []
var glossary 
var glossary_text 
var instructions_text

var next_pressed_instructions = 0


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

onready var P1 = get_node("Backpack/StickerBook/TextureRect/Players/TextureRect")
onready var P2 = get_node("Backpack/StickerBook/TextureRect/Players/TextureRect4")
onready var P3 = get_node("Backpack/StickerBook/TextureRect/Players/TextureRect3")
onready var P4 = get_node("Backpack/StickerBook/TextureRect/Players/TextureRect2")

  

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
	choice_text = get_node("Control/TextureRect/RichTextLabel")
	popup_anim = get_node("Control/AnimationPlayer")
	popup_anim_instructions = get_node("Backpack/Instructions/AnimationPlayer")
	popup_anim_glossary = get_node("Backpack/Glossary/AnimationPlayer")
	sticker_book = get_node("Backpack/StickerBook")
	sticker_book_anim = get_node("Backpack/StickerBook/AnimationPlayer")
	stickers = get_node("Backpack/StickerBook/TextureRect/Stickers")
	glossary = get_node("Backpack/Glossary")
	glossary_text = glossary.get_node("TextureRect/RichTextLabel")
	instructions_text = get_node("Backpack/Instructions/TextureRect/RichTextLabel")
	
	instructions_text.bbcode_text = tr("WELCOME_03") 
		
	glossary_text.bbcode_text = \
		tr("GLOSSARY_01") + "\n" + tr("GLOSSARY_02") + "\n" + \
		tr("GLOSSARY_03") + "\n"

	
	add_all_stickers()
	
	P1.rect_position = Vector2(55, 20)#spaces_position_list[0]
	P2.rect_position = Vector2(110, 20)#spaces_position_list[0]
	P3.rect_position = Vector2(165, 20)#spaces_position_list[0]
	P4.rect_position = Vector2(220, 20)#spaces_position_list[0]


func _on_NextInstruction_pressed():
	next_pressed_instructions += 1
	if next_pressed_instructions == 0:
		instructions_text.bbcode_text = tr("WELCOME_03")
	if next_pressed_instructions == 1:
		instructions_text.bbcode_text = tr("WELCOME_04")
	elif next_pressed_instructions == 2:
		instructions_text.bbcode_text = tr("WELCOME_05")


func add_all_stickers():
	var n = 0
	for sticker in stickers.get_children():
		sticker.texture = sprite_list[n]
		sticker.modulate = Color(0.4, 0.4, 0.4)
		var space_position = sticker.get_child(0).global_position
		space_position -= Vector2(40, 40)
		spaces_position_list.append(space_position)
		n += 1
	print(spaces_position_list)


func reposition_players_on_minimap(player, x):
	if player.name == "Player1":
		P1.rect_position = spaces_position_list[x]
	if player.name == "Player2":
		P2.rect_position = spaces_position_list[x]
	if player.name == "Player3":
		P3.rect_position = spaces_position_list[x]
	if player.name == "Player4":
		P4.rect_position = spaces_position_list[x]
			

# For the popup that re-affirms space
# one for each space
func popup():
	popup_anim.play("popup_choiceObject")


# sets the sprite and text for that category (Action card)
# modulates a sticker once the coresponding space has been landed on
func reset_popup(category, player):
	print("space category: ", category)
	print("Cur player: ", player.name)

	
	if "Justice" in category:
		sprite.texture = sprite_Justice
		choice_text.bbcode_text = tr("ACTION_CARD_01")
		glossary_text.append_bbcode(tr("ACTION_CARD_01") + "\n")
		stickers.get_child(0).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 0)
	elif "Equity" in category:
		sprite.texture = sprite_Equity
		choice_text.bbcode_text = tr("ACTION_CARD_02")
		glossary_text.append_bbcode(tr("ACTION_CARD_02") + "\n")
		stickers.get_child(1).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 1)
	elif "Health" in category:
		sprite.texture = sprite_Health
		choice_text.bbcode_text = tr("ACTION_CARD_03")
		glossary_text.append_bbcode(tr("ACTION_CARD_03") + "\n")
		stickers.get_child(2).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 2)
	elif "Education" in category:
		sprite.texture = sprite_Education
		choice_text.bbcode_text = tr("ACTION_CARD_04")
		glossary_text.append_bbcode(tr("ACTION_CARD_04") + "\n")
		stickers.get_child(3).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 3)
	elif "Housing" in category:
		sprite.texture = sprite_Housing
		choice_text.bbcode_text = tr("ACTION_CARD_05")
		glossary_text.append_bbcode(tr("ACTION_CARD_05") + "\n")
		stickers.get_child(4).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 4)
	elif "Food" in category:
		sprite.texture = sprite_Food
		choice_text.bbcode_text = tr("ACTION_CARD_06")
		glossary_text.append_bbcode(tr("ACTION_CARD_06") + "\n")
		stickers.get_child(5).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 5)
	elif "Community" in category:
		sprite.texture = sprite_Community
		choice_text.bbcode_text = tr("ACTION_CARD_07")
		glossary_text.append_bbcode(tr("ACTION_CARD_07") + "\n")
		stickers.get_child(6).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 6)
	elif "Work" in category:
		sprite.texture = sprite_Work
		choice_text.bbcode_text = tr("ACTION_CARD_08")
		glossary_text.append_bbcode(tr("ACTION_CARD_08") + "\n")
		stickers.get_child(7).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 7)
	elif "Energy" in category:
		sprite.texture = sprite_Energy
		choice_text.bbcode_text = tr("ACTION_CARD_09")
		glossary_text.append_bbcode(tr("ACTION_CARD_09") + "\n")
		stickers.get_child(8).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 8)
	elif "Mutual" in category:
		sprite.texture = sprite_MutualAid
		choice_text.bbcode_text = tr("ACTION_CARD_10")
		glossary_text.append_bbcode(tr("ACTION_CARD_10") + "\n")
		stickers.get_child(9).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 9)
	elif "Migration" in category:
		sprite.texture = sprite_JustMigration
		choice_text.bbcode_text = tr("ACTION_CARD_11")
		glossary_text.append_bbcode(tr("ACTION_CARD_11") + "\n")
		stickers.get_child(10).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 10)
	elif "Nature" in category:
		sprite.texture = sprite_Nature
		choice_text.bbcode_text = tr("ACTION_CARD_12")
		glossary_text.append_bbcode(tr("ACTION_CARD_12") + "\n")
		stickers.get_child(11).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 11)
	elif "Recreation" in category:
		sprite.texture = sprite_Recreation
		choice_text.bbcode_text = tr("ACTION_CARD_13")
		glossary_text.append_bbcode(tr("ACTION_CARD_13") + "\n")
		stickers.get_child(12).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 12)
	elif "Environment" in category:
		sprite.texture = sprite_Environment
		choice_text.bbcode_text = tr("ACTION_CARD_14")
		glossary_text.append_bbcode(tr("ACTION_CARD_14") + "\n")
		stickers.get_child(13).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 13)
	elif "Decolonization" in category:
		sprite.texture = sprite_Decolonization
		choice_text.bbcode_text = tr("ACTION_CARD_15")
		glossary_text.append_bbcode(tr("ACTION_CARD_15") + "\n")
		stickers.get_child(14).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 14)
	elif "Storytelling" in category:
		sprite.texture = sprite_Storytelling
		choice_text.bbcode_text = tr("ACTION_CARD_16")
		glossary_text.append_bbcode(tr("ACTION_CARD_16") + "\n")
		stickers.get_child(15).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 15)
	elif "Transport" in category:
		sprite.texture = sprite_Transport
		choice_text.bbcode_text = tr("ACTION_CARD_17")
		glossary_text.append_bbcode(tr("ACTION_CARD_17") + "\n")
		stickers.get_child(16).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 16)
	elif "Arts" in category:
		sprite.texture = sprite_Arts
		choice_text.bbcode_text = tr("ACTION_CARD_18")
		glossary_text.append_bbcode(tr("ACTION_CARD_18") + "\n")
		stickers.get_child(17).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 17)
	elif "Resources" in category:
		sprite.texture = sprite_Resources
		choice_text.bbcode_text = tr("ACTION_CARD_19")
		glossary_text.append_bbcode(tr("ACTION_CARD_19") + "\n")
		stickers.get_child(18).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 18)
	elif "Truth" in category:
		sprite.texture = sprite_Truth
		choice_text.bbcode_text = tr("ACTION_CARD_20")
		glossary_text.append_bbcode(tr("ACTION_CARD_20") + "\n")
		stickers.get_child(19).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 19)
	elif "Death" in category:
		sprite.texture = sprite_Death
		choice_text.bbcode_text = tr("ACTION_CARD_21")
		glossary_text.append_bbcode(tr("ACTION_CARD_21") + "\n")
		stickers.get_child(20).modulate = Color(1, 1, 1)
		reposition_players_on_minimap(player, 20)
	
	
	


func _on_Backpack_Open_pressed():
	sticker_book_anim.play("popupBackpack")

func _on_BackpackClose_pressed():
	sticker_book_anim.play_backwards("popupBackpack")


func _on_MiniMap_pressed():
	sticker_book_anim.play("popupStickerBook")

func _on_MiniMap_Close_pressed():
	sticker_book_anim.play_backwards("popupStickerBook")	


func _on_Glossary_pressed():
	popup_anim_glossary.play("popupGlossary")

func _on_CloseGlossary_pressed():
	popup_anim_glossary.play_backwards("popupGlossary")


func _on_Instructions_pressed():
	next_pressed_instructions = -1
	_on_NextInstruction_pressed()
	popup_anim_instructions.play("popoupInstructions")

func _on_CloseInstructions_pressed():
	popup_anim_instructions.play_backwards("popoupInstructions")



