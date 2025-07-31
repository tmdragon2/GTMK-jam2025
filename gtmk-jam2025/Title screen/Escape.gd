extends Node


func _physics_process(delta: float) -> void:
	back()
func back():
	if Input.is_action_just_pressed("Escape"):
		get_tree().change_scene_to_file("res://Title screen/Title_screen.tscn")
