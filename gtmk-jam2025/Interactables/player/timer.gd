extends Label
var time= 0

func _ready():
	SignalBus.connect("next_loop", next_loop)
	
func next_loop():
	TimeKeeper.time = time

func _process(delta: float) -> void:
	time += delta
	text = str(snapped(time, 0.01))
	
	
