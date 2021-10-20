extends Node2D

var anim 
var n = "0"
var cur = 0
var roll_counter

signal spinner_done

# Called when the node enters the scene tree for the first time.
func _ready():
	anim = get_node("SpinnerAnim")
	roll_counter = get_node("/root/Main/GUI/TopBar").get_counter()
	self.visible = false

func play(num):
	self.visible = true
	anim.play("Spinner Base")
	n = str(num)
	
func playing():
	return anim.playing

func _on_SpinnerAnim_animation_finished():
	if anim.animation != n:
		roll_counter.text = str(cur + 1)
		print(cur)
		if cur < int(n):
			cur += 1
			anim.play(str(cur))
		else:
			anim.play(str(n))
	else:
		cur = 0
		yield(get_tree().create_timer(1), "timeout")
		emit_signal("spinner_done")
		anim.playing = false
		self.visible = false
