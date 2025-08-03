extends Node2D
var keytaken = false 
var doorcheck = false 
@onready var DOOR_CLOSED = preload("res://Assets/Door.png")
@onready var DOOR_OPENED = preload("res://Assets/Door_Opened.png")
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var item_pointer: Node2D = $item_pointer










func _on_tree_entered() -> void:
	SignalBus.connect("open_door", open_door)
	KeyDoorPositions.door_location = position

func open_door():
	sprite_2d.texture = DOOR_OPENED
	

func _on_tree_exited() -> void:
	SignalBus.disconnect("open_door", open_door)


func _on_collision_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.keytaken == true:
			SignalBus.next_loop.emit()
