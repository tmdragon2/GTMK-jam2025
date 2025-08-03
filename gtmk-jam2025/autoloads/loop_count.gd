extends Node
var loops = 0

func _ready():
	SignalBus.connect("next_loop", next_loop)
	
func next_loop():
	loops += 1
