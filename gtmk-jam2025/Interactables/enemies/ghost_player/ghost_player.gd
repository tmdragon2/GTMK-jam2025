extends CharacterBody2D
var projectile_node: Node
const PROJECTILE = preload("res://projectiles/Projectile.tscn")
var position_array: Array
var shooting_array: Array
var bullets_shot = 0
var frame_counter = 1

func _physics_process(delta: float) -> void:
	if position_array.size() > frame_counter:
		position = position_array[frame_counter]
		frame_counter += 1
		print(shooting_array)
	if shooting_array.size() > bullets_shot:
		if frame_counter == shooting_array[bullets_shot][0]:
			var projectile = PROJECTILE.instantiate()
			projectile.rotation = shooting_array[bullets_shot][2]
			projectile.global_position = shooting_array[bullets_shot][1]
			projectile_node.add_child(projectile)
			bullets_shot += 1
