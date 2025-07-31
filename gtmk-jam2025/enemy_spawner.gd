extends Node
@export var player: CharacterBody2D
const GHOST_PLAYER = preload("res://characters/enemies/ghost_player.tscn")

func next_loop():
	spawn_enemies()
	spawn_ghost_players()
func spawn_enemies():
	pass
	
func spawn_ghost_players():
	var ghost_player = GHOST_PLAYER.instantiate()
	ghost_player.projectile_node = player.projectile_node
	ghost_player.shooting_array = player.get_shoot_array().duplicate(true)
	ghost_player.position_array = player.get_position_array().duplicate(true)
	print(player.get_shoot_array().duplicate(true))
	get_parent().add_child(ghost_player)
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("next_loop"):
		next_loop()
