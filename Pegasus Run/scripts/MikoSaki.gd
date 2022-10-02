extends KinematicBody2D

const GRAVITY = 1300
const JUMP_DISTANCE = 500
var velocity = Vector2()
signal MikoDied
signal jump

func _ready():
	connect("MikoDied", get_tree().get_root().get_node("Node/TextureButton"), "MikoDied")
	connect("MikoDied", get_parent().get_node("sfx"), "MikoDied")
	connect("jump", get_parent().get_node("sfx"), "jump")

func _input(event):
	if event is InputEventKey and event.scancode == KEY_UP and not event.is_echo() and is_on_floor():
		velocity.y = -JUMP_DISTANCE
		emit_signal("jump")

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	move_and_slide(velocity, Vector2(0, -1))
	var colliding = get_node("Area2D").get_overlapping_areas()
	if len(colliding) > 0:
		get_node("AnimatedSprite").play("ohnoes")
		emit_signal("MikoDied")
	elif velocity.y >= 0:
		get_node("AnimatedSprite").play("run")
	else:
		get_node("AnimatedSprite").play("jump")
		
func _process(delta):
	position.x = 224