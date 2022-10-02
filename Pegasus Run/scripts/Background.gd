extends Sprite


func _ready():
	position = Vector2(640, 96)

func _process(delta):
	position.x -= 2
	if position.x == 0:
		position.x = 640
