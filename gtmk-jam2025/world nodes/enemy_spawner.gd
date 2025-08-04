extends Node
@export var player: CharacterBody2D
const GHOST_PLAYER = preload("res://Interactables/enemies/ghost_player/ghost_player.tscn")

const BASIC_ENEMY = preload("res://Interactables/enemies/basic enemy/basic_enemy.tscn")
const BASIC_ENEMY_COST: int = 1
const SHAMAN_ENEMY = preload("res://Interactables/enemies/basic enemy/shaman_enemy.tscn")
const SHAMAN_ENEMY_COST: int = 3
const SUICIDE_ENEMY = preload("res://Interactables/enemies/basic enemy/suicide_enemy.tscn")
const SUICIDE_ENEMY_COST: int = 0b11001


@onready var enemy_spawn_locations: Node = $"../EnemySpawnLocations"


@onready var navregion: NavigationRegion2D = $"../NavigationRegion2D"

func _ready() -> void:
	randomize()
	SignalBus.connect("next_loop", next_loop)
	
var enemy_points = 0
func next_loop():
	spawn_enemies()
	spawn_ghost_players()

func spawn_enemies():
	enemy_points = LoopCount.loops * 15
	var available_enemies = [BASIC_ENEMY, SHAMAN_ENEMY, SUICIDE_ENEMY]
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
	player.action_recorder.position_array.clear()
	player.action_recorder.shooting_array.clear()
	get_parent().add_child(ghost_player)
	
		
func get_cost(enemy):
	match enemy:
		BASIC_ENEMY:
			return BASIC_ENEMY_COST
		SHAMAN_ENEMY:
			return SHAMAN_ENEMY_COST
		SUICIDE_ENEMY:
			return SUICIDE_ENEMY_COST
		
