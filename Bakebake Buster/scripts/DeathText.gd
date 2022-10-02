extends Label

var gamestate = 0
var deadPause = 0

func _ready():
	text = "Reigen died."
	gamestate = 1
	visible = false
	pause_mode = Label.PAUSE_MODE_PROCESS
	
func _process(delta):
	if gamestate == -1:
		deadPause += delta
		if deadPause >= 2:
			text = "Reigen died. \nClick to restart."
			gamestate = 0
		elif deadPause >= 0:
			text = "Reigen died."
	if gamestate == 0:
		if Input.is_action_pressed("mouseclick"):
			get_tree().paused = false
			get_tree().reload_current_scene()
			gamestate = 1
			
			
func ReigenDied():
	deadPause = 0
	visible = true
	gamestate = -1