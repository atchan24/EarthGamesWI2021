extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var card_data = {}
var end_data = {}

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

func update_score(soc, sus):
	society += soc
	sustainability += sus
	print("Society: " + str(society))
	print("Sustainability: " + str(sustainability))
	
func end_game():
	var soc_ending
	var sus_ending
	if society >= 100:
		soc_ending = end_data.society[0]
	elif society >= 50:
		soc_ending = end_data.society[1]
	else:
		soc_ending = end_data.society[2]
	if sustainability >= 100:
		sus_ending = end_data.sustainability[0]
	elif sustainability >= 50:
		sus_ending = end_data.sustainability[1]
	else:
		sus_ending = end_data.sustainability[2]
	var self_ending = []
	var players = get_node("/root/Main/Players").get_children()
	for player in players:
		var score = player.get_score()
		var endings = end_data["self"]
		if score >= 100:
			self_ending.push(endings[0])
		elif score >= 50:
			self_ending.push(endings[1])
		else:
			self_ending.push(endings[2])
	# do some UI stuff here and stop user input
			
func get_society():
	return society
	
func get_sustainability():
	return sustainability
	
	
