extends Enemy
const SPEED = 100



func _process(delta: float) -> void:
	if player != null:
		move_to_target(player.global_position)
		move_and_slide()
		set_animation()
	



func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_method("die"):
			body.die()
		else: print(str(body) + " has no die() function despite being in the player group")
