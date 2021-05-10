extends Spatial

onready var main = preload("res://Scenes/Main.tscn")
# not sure if main is the right thing to call here
onready var progressBar = get_node ("../ProgressBar")
var thread = Thread.new()

func _process(delta):
	if(Input.is_action_just_pressed("ui_accept") && progressBar.value == 0):
		buildLevel(progressBar)

# Called when the node enters the scene tree for the first time.
func buildLevel(progressBar):
	progressBar.start()
	progressBar.hintText = "Calculating Speed"
	yield(get_tree().create_timer(5.0),"timeout")
	randomize()
	progressBar.value = 20
	progressBar.hintText = "Building Level"
	thread.start(self, "instantiateCubes", progressBar)
#started a thread and we need to wait for this thread to finish, why we call exit tree in the end


func instatiateCubes(progressBar):
	var x = -5
	var y = 0
	for i in range (0,80):
		x +=1
		if (x>5):
			y +=1
			x=-5
			
		var position =Vector3(x,y, randf())
		var main_instance = main.instance()
		main_instance.set_name("Main")
		main_instance.translation = position
		add_child (main_instance)
		progressBar.value += 1
		yield(get_tree().create_timer(0.25),"timeout")
		
	progressBar.value = 100
	progressBar.hintText = "Done!"
	progressBar.stop()
	call_deferred("finishThread")
	
func _exit_tree():
	thread.wait_to_finish()

func finishThread():
	thread.wait_to_finish()
	print ("thread is done!")
