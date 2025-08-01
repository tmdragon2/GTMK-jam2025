extends Enemy
func _process(delta: float) -> void:
	if player:
		move_and_slide()
	
func _physics_process(delta: float) -> void:
	set_animation()
	if player and not dead:
		move_to_target(player.global_position)

func _on_hitbox_body_entered(body: Node2D) -> void:
	body_entered_hitbox(body)
		

	
func next_loop():
	queue_free()
