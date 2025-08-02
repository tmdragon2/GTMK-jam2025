extends Node
@export var player: CharacterBody2D
@onready var enemy_spawn_locations: Node = $"../EnemySpawnLocations"
const GHOST_PLAYER = preload("res://Interactables/enemies/ghost_player/ghost_player.tscn")
const BASIC_ENEMY = preload("res://Interactables/enemies/basic enemy/basic_enemy.tscn")
const BASIC_ENEMY_COST = 1
const ENEMIES = [BASIC_ENEMY]


func next_loop():
	spawn_enemies()
	spawn_ghost_players()
	
func spawn_enemies():
	var enemy_points = LoopCount.loops * 5
	var spawn_locations = enemy_spawn_locations.get_children()
	var available_enemies = ENEMIES.duplicate(true)
	while enemy_points != 0:
		var chosen_enemy = ENEMIES.pick_random()
		var enemy_cost = get_enemy_cost(chosen_enemy)
		if enemy_cost > enemy_points:
			available_enemies.erase(chosen_enemy)
		else:
			var max_enemy_amount = floor(enemy_points/enemy_cost)
			var enemy_amount = randi_range(0, max_enemy_amount)
			for i in enemy_amount:
				var chosen_spawn_location = spawn_locations.pick_random()
				var enemy = BASIC_ENEMY.instantiate()
				enemy.position = chosen_spawn_location.position
				enemy.player = player
				get_parent().add_child(enemy)
		
	
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

func get_enemy_cost(enemy):
	match enemy:
		BASIC_ENEMY:
			return BASIC_ENEMY_COST
