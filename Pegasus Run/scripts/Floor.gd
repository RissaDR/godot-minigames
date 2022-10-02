extends Sprite


func _ready():
	position = Vector2(1086, 352)

func _process(delta):
	position.x -= 8
	if position.x <= 1:
		position.x = 1086
