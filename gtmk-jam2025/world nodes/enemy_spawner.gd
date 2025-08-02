extends Node
@export var player: CharacterBody2D
<<<<<<< Updated upstream
const GHOST_PLAYER = preload("res://Interactables/enemies/ghost_player/ghost_player.tscn")
const BASIC_ENEMY = preload("res://Interactables/enemies/basic enemy/basic_enemy.tscn")
const BASIC_ENEMY_COST: int = 1
@onready var enemy_spawn_locations: Node = $"../EnemySpawnLocations"
=======
@onready var navregion: NavigationRegion2D = $"../NavigationRegion2D"


const GHOST_PLAYER = preload("res://characters/enemies/ghost_player/ghost_player.tscn")
const BASIC_ENEMY = preload("res://characters/enemies/basic enemy/basic_enemy.tscn")
const BASIC_ENEMY_COST: int = 1
const LEVEL_WIDTH = 864
const LEVEL_HEIGHT = 480
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
			var spawn_amount = randi_range(0, max_enemies)
			for i in spawn_amount:
				enemy_points -= enemy_cost
				
				var enemy_spawn = enemy_spawn_locations.get_children().pick_random()
				var enemy = chosen_enemy.instantiate()
				enemy.position = enemy_spawn.position
				enemy.player = player
				get_parent().add_child(enemy)
			
=======
			var spawns_amount = randi_range(0, max_enemies)
			var spawn_location = Vector2(randi_range(0, 500), randi_range(0, 500))
			
			var nav_polygon = navregion.navigation_polygon
			var vertices: PackedVector2Array = nav_polygon.vertices

			var all_points: PackedVector2Array = PackedVector2Array()
			
			for polygon in nav_polygon.polygons:
				for i in polygon:
					var point: Vector2 = vertices[i]
					all_points.append(point)
					if Geometry2D.is_point_in_polygon(spawn_location, all_points):
						print("Point is inside")
			
			
			var enemy = chosen_enemy.instantiate()
			enemy.position = Vector2.ZERO
			enemy.player= player
			add_child(enemy)
			enemy_points -= spawns_amount * point_cost
>>>>>>> Stashed changes

		
	
	
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
