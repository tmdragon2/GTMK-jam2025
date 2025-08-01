extends Control
@onready var deathscreen: Panel = $Deathdisplay
func _ready() -> void:
	pass
	


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://world nodes/level area.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
