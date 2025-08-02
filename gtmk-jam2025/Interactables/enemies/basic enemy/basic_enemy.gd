extends Enemy
const SPEED = 100


func _process(delta: float) -> void:
	if player != null:
		move_to_target(player.global_position)
		move_and_slide()
	
func move_to_target(target: Vector2):
	nav_agent.target_position = target
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * SPEED


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_method("die"):
			body.die()
		else: print(str(body) + " has no die() function despite being in the player group")
		
func die():
	queue_free()
	
