extends Spatial


export var card_data = {}
var end_data = {}
var yearly_event_data = {}

var endui = null
onready var bar = get_node("/root/Main/GUI/TopBar")


var society = 0
var sustainability = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	var file2 = File.new()
	var file3 = File.new()
	file.open("res://Assets/cards.json", file.READ)
	file2.open("res://Assets/endings.json", file.READ)
	file3.open("res://Assets/YearlyEvents.json", file.READ)
	var res = JSON.parse(file.get_as_text())
	var res2 = JSON.parse(file2.get_as_text())
	var res3 = JSON.parse(file3.get_as_text())
	if res.error == OK:
		card_data = res.result
	else:
		print("Error: ", res.error)
		print("Error Line: ", res.error_line)
		print("Error String: ", res.error_string)
		get_tree().quit()
	if res2.error == OK:
		end_data = res2.result
	else:
		print("Error: ", res2.error)
		print("Error Line: ", res2.error_line)
		print("Error String: ", res2.error_string)
		get_tree().quit()
	if res3.error == OK:
		yearly_event_data = res3.result
	else:
		print("Error: ", res3.error)
		print("Error Line: ", res3.error_line)
		print("Error String: ", res3.error_string)
		get_tree().quit()
	file.close()
	endui = get_node("/root/Main/GUI/EndingUI")


func update_score(soc, sus):
	# 1. add scores to the game soc and sus
	society += soc
	sustainability += sus
	# 2. update the +X animation label 
	bar.get_node('Control/AnimationPlayer/AddSociety').text = str(soc)
	bar.get_node('Control/AnimationPlayer/AddSustainability').text = str(sus)
	# 3. Play animations 
	if soc != 0:
		bar.get_node('Control/AnimationPlayer').play("AddSociety")
	if sus != 0:
		bar.get_node('Control/AnimationPlayer').play("AddSustainability")
	# 4. Update the Progress bar Label nodes
	bar.get_node('Control/SocietyBar/SocietyScore').text = "Society: "+ str(society) + "-" + str(40)
	bar.get_node('Control/SustainBar/SustainScore').text = "Sustainability: "+ str(sustainability) + "-" + str(40)
	# 5. update the TextureProgress bar nodes and text
	bar.update_score(bar.get_society(), society)
	bar.update_score(bar.get_sustain(), sustainability)
	print("Society: " + str(society))
	print("Sustainability: " + str(sustainability))
	


func end_game():
	var soc_ending
	var sus_ending
	if society >= 40:
		soc_ending = end_data.society.good
	elif society >= 25:
		soc_ending = end_data.society.med
	else:
		soc_ending = end_data.society.bad
	if sustainability >= 40:
		sus_ending = end_data.sustainability.good
	elif sustainability >= 20:
		sus_ending = end_data.sustainability.med
	else:
		sus_ending = end_data.sustainability.bad
	var self_ending = []
	var players = get_node("/root/Main/Players").get_children()
	for player in players:
		var score = player.get_score()
		var endings = end_data["self"]
		if score >= 40:
			self_ending.append(endings.good)
		elif score >= 20:
			self_ending.append(endings.med)
		else:
			self_ending.append(endings.bad)
	# do some UI stuff here and stop user input
	for i in range(0, self_ending.size()):
		endui.get_node("Player" + str(i + 1)).text = self_ending[i]
	bar.visible = false
	endui.get_node("Society").text = soc_ending
	endui.get_node("Sustainability").text = sus_ending
	endui.show()



func get_society():
	return society
	
	
func get_sustainability():
	return sustainability
	
	




