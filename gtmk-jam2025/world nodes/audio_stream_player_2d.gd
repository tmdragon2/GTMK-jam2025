extends AudioStreamPlayer
const high_wave_music: AudioStream = preload("res://Assets/aztecthingy4.wav")
func _ready() -> void:
	SignalBus.connect("next_loop", next_loop)
	
func next_loop():
	if LoopCount.loops >= 5:
		stream = high_wave_music
		playing = true
