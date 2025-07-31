extends Node2D
@onready var barrel: Marker2D = $Barrel
@onready var reload_timer: Timer = $ReloadTimer
@onready var muzzleflash_animation: AnimatedSprite2D = $MuzzleflashAnimation

const PROJECTILE = preload("res://projectiles/Projectile.tscn")
var projectile_node: Node
var points_right: bool = true
var can_shoot = true
var action_recorder: Node
const reload_time = 0.5 #time in seconds

func init(player, projectiles, action_recorder_node):
	projectile_node = projectiles
	action_recorder = action_recorder_node
func _ready() -> void:
	muzzleflash_animation.visible = false
	
func _physics_process(delta: float) -> void:
	look_at_mouse()
	
func shoot():
	if can_shoot == true:
		can_shoot = false
		muzzleflash_animation.visible = true
		muzzleflash_animation.play()
		reload_timer.start(reload_time)
		
		var projectile = PROJECTILE.instantiate()
		projectile.rotation = rotation
		projectile.global_position = barrel.global_position
		projectile_node.add_child(projectile)
		
		action_recorder.update_shoot_array(barrel.global_position, rotation)
		


func _on_muzzleflash_animation_animation_finished() -> void:
	muzzleflash_animation.visible = false


func _on_reload_timer_timeout() -> void:
	can_shoot = true

func look_at_mouse():
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	var mouse_right = points_right
	if mouse_position.x > global_position.x:
		mouse_right = true
	if mouse_position.x < global_position.x:
		mouse_right = false
	if  points_right != mouse_right:
		scale.y *= -1 #flips gun vertically
		points_right = not points_right #inverts boolean
