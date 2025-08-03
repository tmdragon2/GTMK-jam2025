extends Node2D
var keytaken = false 
var doorcheck = false 
var checkwalls 
@onready var raycast1 = $RayCast2D
@onready var raycast2 = $RayCast2D2
@onready var raycast3 = $RayCast2D3
@onready var raycast4 = $RayCast2D4
signal dooropened


func _process(delta: float) -> void:
	if keytaken == true: 
		if doorcheck == true: 
			emit_signal("dooropened")
			
func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if keytaken == false:
			body.keytaken = true
			SignalBus.open_door.emit()
func walldetection():
	if raycast1.is_colliding():
		move_toward(1,1,1)
	if raycast2.is_colliding():
		move_toward(1,1,1)
	if raycast3.is_colliding():
		move_toward(1,1,1)
	if raycast4.is_colliding():
		move_toward(1,1,1)
