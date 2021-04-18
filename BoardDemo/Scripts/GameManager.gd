extends Spatial

export var card_data = {}
var end_data = {}
var endui = null

var society = 0
var sustainability = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	var file2 = File.new()
	file.open("res://Assets/sample_cards.json", file.READ)
	file2.open("res://Assets/endings.json", file.READ)
	var res = JSON.parse(file.get_as_text())
	var res2 = JSON.parse(file2.get_as_text())
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
	file.close()
	endui = get_node("/root/Main/GUI/EndingUI")

func update_score(soc, sus):
	society += soc
	sustainability += sus
	print("Society: " + str(society))
	print("Sustainability: " + str(sustainability))
	
func end_game():
	var soc_ending
	var sus_ending
	if society >= 100:
		soc_ending = end_data.society.good
	elif society >= 50:
		soc_ending = end_data.society.med
	else:
		soc_ending = end_data.society.bad
	if sustainability >= 100:
		sus_ending = end_data.sustainability.good
	elif sustainability >= 50:
		sus_ending = end_data.sustainability.med
	else:
		sus_ending = end_data.sustainability.bad
	var self_ending = []
	var players = get_node("/root/Main/Players").get_children()
	for player in players:
		var score = player.get_score()
		var endings = end_data["self"]
		if score >= 100:
			self_ending.append(endings.good)
		elif score >= 50:
			self_ending.append(endings.med)
		else:
			self_ending.append(endings.bad)
	# do some UI stuff here and stop user input
	for i in range(0, self_ending.size()):
		endui.get_node("Player" + str(i + 1)).text = self_ending[i]
	endui.get_node("Society").text = soc_ending
	endui.get_node("Sustainability").text = sus_ending
	endui.show()
			
func get_society():
	return society
	
func get_sustainability():
	return sustainability
	
	
