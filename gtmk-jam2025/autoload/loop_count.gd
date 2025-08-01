extends Node
var loops = 1
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("next_loop"):
		next_loop()
		
func next_loop():
	loops += 1
