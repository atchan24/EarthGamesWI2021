extends Control

onready var self_bar = get_node("SelfBar")
onready var society_bar = get_node("SocietyBar")
onready var sustain_bar = get_node("SustainBar")

func update_score(node, score):
	node.value = score

func get_counter():
	return get_node("RollsCounter")	
	
func get_self():
	return self_bar

func get_society():
	return society_bar

func get_sustain():
	return sustain_bar
