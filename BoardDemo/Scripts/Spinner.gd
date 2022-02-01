extends Node2D

var anim 
var animPlayer
var n = "0"
var cur = 0
var roll_counter

signal spinner_done

# Called when the node enters the scene tree for the first time.
func _ready():
	anim = get_node("SpinnerAnim")
	animPlayer = get_node("AnimationPlayer")
	roll_counter = get_node("/root/Main/GUI/TopBar").get_counter()


func play(num):
	animPlayer.play("Ready")
	yield(animPlayer, "animation_finished")
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
		yield(get_tree().create_timer(1.5), "timeout")
		anim.playing = false
		animPlayer.play_backwards("Ready")
		yield(animPlayer, "animation_finished")
		emit_signal("spinner_done")

