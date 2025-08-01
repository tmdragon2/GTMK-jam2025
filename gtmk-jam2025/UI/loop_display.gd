extends Label

func next_loop():
	text = "loop " + str(LoopCount.loops)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("next_loop"):
		next_loop()
