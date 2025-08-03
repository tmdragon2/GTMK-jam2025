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
func _physics_process(delta: float) -> void:
	if animation_array.size() > frame_counter:
		var animation = animation_array[frame_counter]
		if animation != animated_sprite_2d.animation:
			print(str(animation) +" " +str(animated_sprite_2d.animation))
			animated_sprite_2d.play(animation)
	
	if position_array.size() > frame_counter:
		position = position_array[frame_counter]
		frame_counter += 1
	if shooting_array.size() > bullets_shot:
		if frame_counter == shooting_array[bullets_shot][0]:
			var projectile = PROJECTILE.instantiate()
			projectile.rotation = shooting_array[bullets_shot][2]
			projectile.global_position = shooting_array[bullets_shot][1]
			projectile_node.add_child(projectile)
			bullets_shot += 1
	var move_right = look_right
	if position_array.size() > frame_counter +1:
		var speed = position_array[frame_counter + 1] - position
		if speed.x > 0:
			move_right = true
		if speed.x < 0:
			move_right = false
		if look_right != move_right:
			animated_sprite_2d.scale.x *= -1 #flips character horizontally
			look_right = not look_right #inverts boolean
		
