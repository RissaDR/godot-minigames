extends AudioStreamPlayer

var doot = load("res://assets/sfx/doot.ogg")
var daat = load("res://assets/sfx/daat.ogg")

func _ready():
	pause_mode = PAUSE_MODE_PROCESS
func jump():
	set_stream(doot)
	playing = true

func MikoDied():
	get_tree().paused = true
	set_stream(daat)
	playing = true

	