extends Sprite

var initialpos = position
var moveup
signal sqIsFree
signal minetaPew

func _ready():
	initialpos = position
	if position.y == 128:
		z_index = -400
	elif position.y == 256:
		z_index = -300
	elif position.y == 384:
		z_index = -200
	moveup = 0
	get_node("AnimatedSprite").play("blink")
	get_node("TextureButton").connect("pressed", self, "pressed")
	connect("sqIsFree", get_tree().get_root().get_node("Node"), "sqIsFree")
	connect("minetaPew", get_tree().get_root().get_node("Node"), "minetaPew")
	
func _process(delta):
	if moveup != 30:
		moveup += 1
		position.y -= 1
	
func pressed():
	get_node("TextureButton").disconnect("pressed", self, "pressed")
	emit_signal("sqIsFree", initialpos)
	emit_signal("minetaPew")
	z_index = 200
	get_node("AnimatedSprite").play("explode")
	get_node("AnimatedSprite").connect("animation_finished", self, "animation_finished")

func animation_finished():
	queue_free()