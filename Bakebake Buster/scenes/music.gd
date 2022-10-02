extends AudioStreamPlayer

func _ready():
	playing = true

func bakebakeIsNear():
	pitch_scale = 1.5
	
func ReigenIsSafe():
	pitch_scale = 1
	
func ReigenDied():
	playing = false
