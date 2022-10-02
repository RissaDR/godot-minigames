extends TextureButton

func _ready():
	visible = false
	pause_mode = PAUSE_MODE_PROCESS

func MikoDied():
	visible = true
	
func pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()