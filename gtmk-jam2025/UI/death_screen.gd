extends Control
@onready var deathscreen: Panel = $Deathdisplay

func _ready() -> void:
	$Label.text = ("You made it through " +str(LoopCount.loops)+" loop(s)")
	


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Title screen/Title_screen.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
