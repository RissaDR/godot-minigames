extends KinematicBody2D

var speed = 400
var move = Vector2()

func _ready():
	position = Vector2(1216, 288)

func _process(delta):
	move.x = speed * -1 * delta
	move_and_collide(move)

func levelSet(level):
	if level >= 4:
		speed = 500
	if level >= 9:
		speed = 600