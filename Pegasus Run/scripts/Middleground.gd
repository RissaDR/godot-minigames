extends Sprite


func _ready():
	position = Vector2(1500, 192)

func _process(delta):
	position.x -= 5
	if position.x <= -296:
		position.x = 1500
