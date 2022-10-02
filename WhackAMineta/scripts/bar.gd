extends Sprite

var showing = false
var text = 0

func _ready():
	visible = true
	pause_mode = PAUSE_MODE_PROCESS
	get_tree().paused = true
	showing = true
	text = 0
	scale.y = 0
	get_node("Title").visible = false
	get_node("ClickToStart").visible = false
	get_node("ClickToTryAgain").visible = false

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and not event.is_echo() and text == 0:
		visible = false
		showing = false
		scale.y = 0
		get_tree().paused = false
		get_node("Title").visible = false
		get_node("ClickToStart").visible = false
		get_node("ClickToTryAgain").visible = false
	elif event is InputEventMouseButton and event.is_pressed() and not event.is_echo() and text == 1:
		visible = false
		showing = false
		scale.y = 0
		get_tree().paused = false
		get_tree().reload_current_scene()
		get_node("Title").visible = false
		get_node("ClickToStart").visible = false
		get_node("ClickToTryAgain").visible = false

func _process(delta):
	if showing == true:
		if scale.y <= 0.75:
			scale.y += 0.05
		else:
			if text == 0:
				get_node("Title").visible = true
				get_node("ClickToStart").visible = true
			elif text == 1:
				get_node("Title").visible = true
				get_node("ClickToTryAgain").visible = true

func expelled():
	get_tree().paused = true
	visible = true
	showing = true
	text = 1