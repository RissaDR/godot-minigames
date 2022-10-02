extends AudioStreamPlayer

var dootduut = load("res://assets/sfx/dootduut.ogg")

func _ready():
	pause_mode = PAUSE_MODE_PROCESS
	
func milestone():
	set_stream(dootduut)
	playing = true
