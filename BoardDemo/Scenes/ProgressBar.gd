extends ProgressBar

var hintText = ""
var dots = ""

onready var loadingHint = get_node("LoadingHint")
var timer= Timer.new()

func start ():
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.set_wait_time(0.5)
	add_child(timer)
	timer.start()
	
func _on_timer_timeout():
		dots += "."
		if(dots == "...."):
			dots= ""
			
		loadingHint.text = hintText +dots
	
func stop():
	timer.stop()
	dots=""
	loadingHint.text = hintText + dots
	
