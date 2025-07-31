extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var anim_component: Node = $AnimationComponent
@onready var gun: Node2D = $gun

@export var projectile_node: Node
@export var player: CharacterBody2D
@export var speed = 200
@export var friction = 0.15
@export var acceleration = 0.1

var dead: bool = false
func _ready() -> void:
	anim_component.init(self, animated_sprite_2d)
	gun.init(self, projectile_node)

func _physics_process(delta):
	if not dead:
		movement()
		anim_component.set_animation()
		if Input.is_action_just_pressed("shoot"):
			gun.shoot()
		move_and_slide()
	
	
func movement():
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
		if velocity.x > -0.02 or velocity.x < 0.02 and velocity.y > -0.02 or velocity.y < 0.02 and direction != Vector2(0.0, 0.0):
			velocity = Vector2.ZERO

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input

func die():
	dead = true
	gun.queue_free()
	anim_component.play_animation("die")
	await animated_sprite_2d.animation_finished
	queue_free()
