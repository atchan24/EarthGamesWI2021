extends Node

var loader
var time_max = 100
var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	#get_node("/root/Loading").visible = false
	
func goto_scene(path):
	loader = ResourceLoader.load_interactive(path)
	if loader == null:
		print("error in generating loader")
		return
	#get_node("/root/Loading").visible = true
	set_process(true)
	current_scene.queue_free()
	# add some nice looking stuff here
	
	
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
			#get_node("/root/Loading").visible = false
			break
		elif err == OK:
			# update_progress()
			pass
		else: # Error during loading.
			print("Error during loading: " + err)
			loader = null
			break

# func update_progress():
#	pass

func set_new_scene(scene_resource):
	current_scene = scene_resource.instance()
	get_node("/root").add_child(current_scene)
	