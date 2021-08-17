# global script file that can be accessed using get_node("root/Global")

extends Node

var loader
var time_max = 100
var current_scene = null

var card_data
var end_data

# Called when the node enters the scene tree for the first time.
func _ready():
	load_files()
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	get_node("/root/Loading").visible = false

# facilitates scene transition using a loading screen with a given path
func goto_scene(path):
	loader = ResourceLoader.load_interactive(path)
	if loader == null:
		print("error in generating loader")
		return
	get_node("/root/Loading").visible = true
	set_process(true)
	current_scene.queue_free()
	
func _process(delta):
	if loader == null:
		set_process(false)
		return
	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max:
		var err = loader.poll()
		if err == ERR_FILE_EOF: # Finished loading.
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			print("Finished loading")
			get_node("/root/Loading").visible = false
			get_node("/root/Loading/CanvasLayer/Background").visible = false
			break
		elif err == OK:
			# update_progress()
			pass
		else: # Error during loading.
			print("Error during loading: " + err)
			loader = null
			break

func get_card_data():
	return card_data
	
func get_end_data():
	return end_data

func set_new_scene(scene_resource):
	current_scene = scene_resource.instance()
	get_node("/root").add_child(current_scene)
	
# reads the json files for the card and ending data 
func load_files():
	var file = File.new()
	var file2 = File.new()
	file.open("res://Assets/cards.json", file.READ)
	file2.open("res://Assets/endings.json", file.READ)
	var res = JSON.parse(file.get_as_text())
	var res2 = JSON.parse(file2.get_as_text())
	if res.error == OK:
		card_data = res.result
	else:
		print("Error: ", res.error)
		print("Error Line: ", res.error_line)
		print("Error String: ", res.error_string)
		get_tree().quit() # exits game if file errors out
	if res2.error == OK:
		end_data = res2.result
	else:
		print("Error: ", res2.error)
		print("Error Line: ", res2.error_line)
		print("Error String: ", res2.error_string)
		get_tree().quit()
	file.close()
	file2.close()
	
