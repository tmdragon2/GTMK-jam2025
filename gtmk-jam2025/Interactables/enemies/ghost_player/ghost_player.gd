extends CharacterBody2D
var projectile_node: Node
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const PROJECTILE = preload("res://projectiles/ghost_projectile.tscn")
var position_array: Array
var shooting_array: Array
var animation_array: Array
var bullets_shot = 0
var frame_counter = 1
var look_right = true
var private_position_array: Array
var private_shooting_array: Array
var private_animation_array: Array

func _ready() -> void:
	SignalBus.connect("next_loop", next_loop)
	private_position_array = position_array.duplicate(true)
	private_animation_array = animation_array.duplicate(true)
	private_shooting_array = shooting_array.duplicate(true)
func _physics_process(delta: float) -> void:
	if private_animation_array.size() > frame_counter:
		var animation = private_animation_array[frame_counter]
		if animation != animated_sprite_2d.animation:
			print(str(animation) +" " +str(animated_sprite_2d.animation))
			animated_sprite_2d.play(animation)
	
	if private_position_array.size() > frame_counter:
		position = private_position_array[frame_counter]
		frame_counter += 1
	if private_shooting_array.size() > bullets_shot:
		if frame_counter == private_shooting_array[bullets_shot][0]:
			var projectile = PROJECTILE.instantiate()
			projectile.rotation = private_shooting_array[bullets_shot][2]
			projectile.global_position = private_shooting_array[bullets_shot][1]
			projectile_node.add_child(projectile)
			bullets_shot += 1
	var move_right = look_right
	if private_position_array.size() > frame_counter +1:
		var speed = private_position_array[frame_counter + 1] - position
		if speed.x > 0:
			move_right = true
		if speed.x < 0:
			move_right = false
		if look_right != move_right:
			animated_sprite_2d.scale.x *= -1 #flips character horizontally
			look_right = not look_right #inverts boolean
	
func next_loop():
	frame_counter = 1
	bullets_shot = 0
		
