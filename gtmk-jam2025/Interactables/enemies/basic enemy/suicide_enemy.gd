extends Enemy
const SPEED = 100
var is_detonating: bool = false
var dying: bool = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _process(delta: float) -> void:
	if dying:
		velocity *= 0.97
	if player != null:
		move_to_target(player.global_position)
		move_and_slide()
		if not is_detonating:
			set_animation()



func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not is_detonating:
		audio_stream_player.play()
		is_detonating = true
		animated_sprite_2d.play("die")
		await animated_sprite_2d.animation_finished
		body.die()
		queue_free()
	
func die():
	dying = true
	dead = true
	if animated_sprite.sprite_frames.has_animation("die"):
		animated_sprite.play("die")
		await animated_sprite.animation_finished
		queue_free()
