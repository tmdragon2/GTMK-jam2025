extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var anim_component: Node = $AnimationComponent
@onready var gun: Node2D = $gun
@onready var action_recorder: Node = $ActionRecorder
@export var projectile_node: Node
@export var player: CharacterBody2D
@export var speed = 200
@export var friction = 0.15
@export var acceleration = 0.1
@onready var player_spawn_locations: Node = $"../PlayerSpawnLocations"
@onready var item_pointer: Node2D = $item_pointer
@onready var invincibility: Timer = $invincibility

var invincible: bool = true
var keytaken: bool = false
var dead: bool = false

func _ready() -> void:
	SignalBus.connect("next_loop", next_loop)
	anim_component.init(self, animated_sprite_2d)
	gun.init(self, projectile_node, action_recorder)

func _physics_process(delta):
	pause_check()
	if not dead:
		movement()
		anim_component.set_animation()
		if Input.is_action_just_pressed("shoot"):
			gun.shoot()
		move_and_slide()
	if keytaken and item_pointer != null:
		item_pointer.look_at(KeyDoorPositions.door_location)
	else:
		item_pointer.look_at(KeyDoorPositions.key_location)

	
	
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
	
func pause_check():
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://UI/Title screen/Title_screen.tscn")
func key_check():
	pass
	
func die():
	if dead == false and invincible == false:
		dead = true
		anim_component.play_animation("die")
		await animated_sprite_2d.animation_finished
		get_tree().change_scene_to_file("res://UI/death_screen.tscn")
	
func get_position_array():
	var position_array = action_recorder.position_array
	
	return position_array
func get_shoot_array():
	var shooting_array = action_recorder.shooting_array
	return shooting_array



func next_loop():
	keytaken = false
	global_position = player_spawn_locations.get_children().pick_random().global_position
	item_pointer.visible = false
	invincibility.start(3)
	invincible = true

func get_animation():
	var animation = animated_sprite_2d.animation
	return animation


func _on_invincibility_timeout() -> void:
	invincible = false
