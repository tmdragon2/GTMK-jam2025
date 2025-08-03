extends AudioStreamPlayer
const high_wave_music = preload("res://Assets/aztecthingamajig2.wav")
func _ready() -> void:
	SignalBus.connect("next_loop", next_loop)
	
func next_loop():
	if LoopCount.loops >= 8:
		stream = high_wave_music
		playing = true
