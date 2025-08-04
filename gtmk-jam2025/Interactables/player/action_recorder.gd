extends Node
@onready var player: CharacterBody2D = $".."
var animation = "idle"
var bullets_shot = 0
var frame_counter = 0
var position_array: Array
var shooting_array: Array 
var projectile_node: Node
const PROJECTILE = preload("res://projectiles/Projectile.tscn")
#[the frame the first bullet was shot at, the position it started, the roatation of the bullet]
#[the frame the second bullet was shot at, the position it started, the roatation of the bullet]
#[the frame the third bullet was shot at, the position it started, the rotation of the bullet] etc.

func init(player_node, projectiles, action_recorder_node):
	player = player_node
	projectile_node = projectiles

func _physics_process(delta: float) -> void:
	position_array.append(player.position)
	frame_counter += 1

	
func update_shoot_array(bullet_start_pos, bullet_rotation):
	shooting_array.append([frame_counter, bullet_start_pos, bullet_rotation])
	
func _ready() -> void:
	SignalBus.connect("next_loop", next_loop)
	
func next_loop():
	pass
		#var projectile = PROJECTILE.instantiate()
		#projectile.rotation = rotation
		#projectile.global_position = barrel.global_position
		#projectile_node.add_child(projectile)
