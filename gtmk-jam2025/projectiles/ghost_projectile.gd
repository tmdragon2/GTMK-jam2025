extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var speed  = 250

func _ready():
	velocity = Vector2(speed, 0).rotated(rotation)
	
func _process(delta: float) -> void:
	move_and_slide()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_method("die"):
			body.die()
		destroy_projectile()
		
func destroy_projectile():
	velocity = Vector2.ZERO
	animated_sprite_2d.play("collision")
	await animated_sprite_2d.animation_finished
	queue_free()
