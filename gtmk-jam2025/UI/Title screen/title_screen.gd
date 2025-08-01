extends Control
@onready var options: Panel = $Options
@onready var mainbuttons: VBoxContainer = $ColorRect/Mainbuttons

func _ready() -> void:
	options.visible = false
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://world nodes/level area.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
	## we can put credits here if we run out of time and we cant add any options for the gameplay
	mainbuttons.visible = false
	options.visible = true
	get_tree()


func _on_settings_leave_pressed() -> void:
	get_tree().change_scene_to_file("res://Title screen/Title_screen.tscn")
