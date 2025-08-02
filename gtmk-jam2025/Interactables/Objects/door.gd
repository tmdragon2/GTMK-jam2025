extends Node2D
var keytaken = false 
var doorcheck = false 







func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.keytaken == true:
			SignalBus.next_loop.emit()
			queue_free()
