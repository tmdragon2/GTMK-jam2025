extends Node2D
var keytaken = false 
var doorcheck = false 
signal dooropened

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		if keytaken == false:
			keytaken = true
			queue_free()

func _process(delta: float) -> void:
	if keytaken == true: 
		if doorcheck == true: 
			emit_signal("dooropened")



func _on_wallcheck_body_entered(body: Node2D) -> void:
	queue_free()
