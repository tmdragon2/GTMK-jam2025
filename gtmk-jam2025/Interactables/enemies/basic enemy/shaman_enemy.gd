extends Enemy
const SPEED = 100
@onready var bullet_start_pos: Marker2D = $BulletStartPos
var shooting = false
const GHOST_PROJECTILE = preload("res://projectiles/ghost_projectile.tscn")

func _process(delta: float) -> void:
	if player != null and not shooting:
		move_to_target(player.global_position)
		move_and_slide()
		set_animation()
	



func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_method("die"):
			body.die()
		else: print(str(body) + " has no die() function despite being in the player group")


func _on_timer_timeout() -> void:
	shoot()
	
func shoot():
	animated_sprite.play("shoot")
	shooting = true
	var projectile = GHOST_PROJECTILE.instantiate()
	projectile.look_at(player.position)
	projectile.global_position = bullet_start_pos.global_position
	get_parent().add_child(projectile)
	await animated_sprite.animation_finished
	shooting = false
	animated_sprite.play("walk")
	
