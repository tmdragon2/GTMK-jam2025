extends Node
@export var player: CharacterBody2D
const GHOST_PLAYER = preload("res://Interactables/enemies/ghost_player/ghost_player.tscn")
const BASIC_ENEMY = preload("res://Interactables/enemies/basic enemy/basic_enemy.tscn")
const BASIC_ENEMY_COST: int = 1
@onready var enemy_spawn_locations: Node = $"../EnemySpawnLocations"

var enemy_points = 0
func next_loop():
	spawn_enemies()
	spawn_ghost_players()

func spawn_enemies():
	enemy_points = LoopCount.loops * 5
	var available_enemies = [BASIC_ENEMY]
	
	while enemy_points != 0:
		var chosen_enemy = available_enemies.pick_random()
		var enemy_cost = get_cost(chosen_enemy)
		var max_enemies = floor(enemy_points / enemy_cost)
		if max_enemies == 0:
			available_enemies.erase(chosen_enemy)
		else:
			var spawn_amount = randi_range(0, max_enemies)
			for i in spawn_amount:
				enemy_points -= enemy_cost
				
				var enemy_spawn = enemy_spawn_locations.get_children().pick_random()
				var enemy = chosen_enemy.instantiate()
				enemy.position = enemy_spawn.position
				enemy.player = player
				get_parent().add_child(enemy)
			

		
	
	
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
