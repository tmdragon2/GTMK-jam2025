extends Node
var player = CharacterBody2D
var animated_sprite_2d: AnimatedSprite2D
var looks_right: bool = true

func init(player_node, animated_sprite_2d_node):
	player = player_node
	animated_sprite_2d = animated_sprite_2d_node
	
func set_animation():
	var required_animation = "idle"
	if player.velocity != Vector2.ZERO:
		required_animation = "run"
	animated_sprite_2d.play(required_animation)
	var moves_right = looks_right
	if player.velocity.x > 0:
		moves_right = true
	if player.velocity.x < 0:
		moves_right = false
	if looks_right != moves_right:
		animated_sprite_2d.scale.x *= -1 #flips character horizontally
		looks_right = not looks_right #inverts boolean
	
