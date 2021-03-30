extends Node2D

var anim 
var n
var cur = 0

signal spinner_done

# Called when the node enters the scene tree for the first time.
func _ready():
	anim = get_node("SpinnerAnim")
	self.visible = false

func play(num):
	self.visible = true
	anim.play("Spinner Base")
	n = str(num)

func _on_SpinnerAnim_animation_finished():
	if anim.animation != n:
		print(cur)
		if cur < int(n):
			cur += 1
			anim.play(str(cur))
		else:
			anim.play(str(n))
	else:
		cur = 0
		yield(get_tree().create_timer(1.5), "timeout")
		emit_signal("spinner_done")
		self.visible = false
