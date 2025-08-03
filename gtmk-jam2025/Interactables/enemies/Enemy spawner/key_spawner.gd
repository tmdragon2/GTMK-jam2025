extends Node2D
@onready var key_location = preload("res://Interactables/Objects/Key.tscn")

@export var pointA: Vector2 = Vector2(50,50)
@export var pointB: Vector2 = Vector2(1100, 600)


func get_boxpoint(p1: Vector2, p2: Vector2) -> Vector2:
	var A_value: float = randf_range(p1.x, p2.x)
	var B_value: float = randf_range(p1.y, p2.y)
	var randomize_keyspawn: Vector2 = Vector2(A_value, B_value)
	return (randomize_keyspawn)


func spawn_key():
	var key_instance: Node = key_location.instantiate()
	add_child(key_instance)
	var spawn_location: Vector2 = get_boxpoint(pointA,pointB)
	key_instance.set_position(spawn_location)
	
	
func _ready() -> void:
		spawn_key()
		randomize()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		spawn_key()
