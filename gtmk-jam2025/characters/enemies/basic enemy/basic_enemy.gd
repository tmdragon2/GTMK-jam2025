extends CharacterBody2D
const SPEED = 100
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@export var player: CharacterBody2D

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
		
