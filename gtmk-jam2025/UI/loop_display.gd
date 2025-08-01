extends Label
var current_loop: int = 0

func next_loop():
	current_loop += 1
	text = "loop " + str(current_loop)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("next_loop"):
		next_loop()
