extends CharacterBody2D
const SPEED = 100
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D


func _process(delta: float) -> void:
	move_to_target(Vector2.ZERO)
	move_and_slide()
	
func move_to_target(target: Vector2):
	nav_agent.target_position = target
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * SPEED
