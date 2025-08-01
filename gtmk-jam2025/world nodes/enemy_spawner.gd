extends Node
@export var player: CharacterBody2D

const GHOST_PLAYER = preload("res://characters/enemies/ghost_player/ghost_player.tscn")
const BASIC_ENEMY = preload("res://characters/enemies/basic enemy/basic_enemy.tscn")
const BASIC_ENEMY_COST: int = 1

var enemy_points = 0
func next_loop():
	spawn_enemies()
	spawn_ghost_players()

func spawn_enemies():
	enemy_points = LoopCount.loops * 5
	var available_enemies = [BASIC_ENEMY]
	
	while enemy_points != 0:
		var chosen_enemy = available_enemies.pick_random()
		var point_cost = get_cost(chosen_enemy)
		var max_enemies = floor(enemy_points / point_cost)
		if max_enemies == 0:
			available_enemies.erase(chosen_enemy)
		else:
			var spawns_amount = randi_range(0, max_enemies)

		
	
	
func spawn_ghost_players():
	var ghost_player = GHOST_PLAYER.instantiate()
	ghost_player.projectile_node = player.projectile_node
	ghost_player.shooting_array = player.get_shoot_array().duplicate(true)
	ghost_player.position_array = player.get_position_array().duplicate(true)
	get_parent().add_child(ghost_player)
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("next_loop"):
		next_loop()
		
func get_cost(enemy):
	match enemy:
		BASIC_ENEMY:
			return BASIC_ENEMY_COST
