extends Label

func _ready() -> void:
	SignalBus.connect("next_loop", next_loop)

func next_loop():
	text = "loops:" + str(LoopCount.loops)
