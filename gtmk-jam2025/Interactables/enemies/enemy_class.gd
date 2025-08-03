extends CharacterBody2D
class_name Enemy
@export var speed: int
@export var player: CharacterBody2D
@export var nav_agent: NavigationAgent2D
@export var contact_damage: bool = true
@export var animated_sprite: AnimatedSprite2D

var dead: bool = false
var looks_right: bool = true

func move_to_target(target: Vector2):
	if not dead:
		nav_agent.target_position = target
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * speed

func body_entered_hitbox(body: Node2D) -> void:
	if contact_damage == true:
		if body.is_in_group("player"):
			if body.has_method("die"):
				body.die()
			else: print(str(body) + " has no die() function despite being in the player group")

func set_animation():
		if animated_sprite:
			if not dead:
				animated_sprite.play("walk")
				var moves_right = looks_right
				if velocity.x > 0:
					moves_right = true
				if velocity.x < 0:
					moves_right = false
				if looks_right != moves_right:
					animated_sprite.scale.x *= -1 #flips character horizontally
					looks_right = not looks_right #inverts boolean
			else:
				animated_sprite.self_modulate.a /= 1.05

func die():
	dead = true
	velocity = Vector2.ZERO
	if animated_sprite.sprite_frames.has_animation("die"):
		animated_sprite.play("die")
		animated_sprite.self_modulate.a = .5
		await animated_sprite.animation_finished
		queue_free()
		
		
		
		
