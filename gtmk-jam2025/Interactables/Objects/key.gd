extends Node2D
var keytaken = false 
var doorcheck = false 
signal dooropened


func _process(delta: float) -> void:
	if keytaken == true: 
		if doorcheck == true: 
			emit_signal("dooropened")




func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if keytaken == false:
			body.keytaken = true
			queue_free()

func _on_collide_detection_body_entered(body: Node2D) -> void:
	queue_free()
