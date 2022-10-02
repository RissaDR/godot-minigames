extends KinematicBody2D

signal killed
#var elapsed = 0
#var spawnPoint
var level
var size 
var lifebar = 1
var centre = Vector2(320, 320)
var currentPos = Vector2()
var velocity = Vector2()
var distance = Vector2()
var speed = 4 # easing
var explodewait = 0
var safe = 0

func _ready():
	safe = 0
	#pause_mode = RichTextLabel.PAUSE_MODE_PROCESS
	modulate = Color(1, 1, 1, 1)
	level = randi()%3+1
	lifebar = level
	size = level
	speed -= level
	scale = Vector2(size, size)
	#spawnPoint = get_position()
# warning-ignore:return_value_discarded
	get_node("TextureButton").connect("pressed", self, "bakeclick")
# warning-ignore:return_value_discarded
	connect("killed", self, "killed")
	$AnimatedSprite.play()
	explodewait = 0
	

func bakeclick():
	modulate -= Color(0, 0, 0, 0.3)
	lifebar -= 1
	
func _process(delta):
#	if elapsed >= speed:
#		position = centre
#	else:
#		elapsed += delta
#		var intermediate = (centre-spawnPoint) / (elapsed/speed) + spawnPoint
#		position = intermediate
	if lifebar <= 0:
		if safe == 0:
			emit_signal("killed")
			safe = 1
		modulate = Color(1, 1, 1, 1)
		$AnimatedSprite.play("explode")
		if explodewait <= 0.8:
			explodewait += delta
		else:
			queue_free()
	else:
		currentPos = get_position()
		distance.x = centre.x - currentPos.x
		distance.y = centre.y - currentPos.y
		velocity.x = distance.x * speed * delta/2
		velocity.y = distance.y * speed * delta/2
		currentPos.x += velocity.x
		currentPos.y += velocity.y
		set_position(currentPos)

func killed():
	$Area2D.queue_free()

