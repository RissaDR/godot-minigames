extends Sprite

var initialpos = position
var moveup
var movedown
var onscrtime = 3
var onscrtimeCount = 0
signal sqIsFree
signal hitoshiPew


func _ready():
	initialpos = position
	if position.y == 128:
		z_index = -400
	elif position.y == 256:
		z_index = -300
	elif position.y == 384:
		z_index = -200
	moveup = 0
	movedown = 0
	get_node("AnimatedSprite").play("blink")
	var onscrtimeCount = 0
	get_node("TextureButton").connect("pressed", self, "pressed")
	connect("sqIsFree", get_tree().get_root().get_node("Node"), "sqIsFree")
	connect("hitoshiPew", get_tree().get_root().get_node("Node"), "hitoshiPew")

func _process(delta):
	if moveup != 30:
		moveup += 1
		position.y -= 1
	onscrtimeCount += delta
	if onscrtimeCount >= onscrtime:
		if movedown != 30:
			movedown += 1
			position.y += 1
		else:
			queue_free()
			emit_signal("sqIsFree", initialpos)
	
func pressed():
	get_node("TextureButton").disconnect("pressed", self, "pressed")
	emit_signal("sqIsFree", initialpos)
	emit_signal("hitoshiPew")
	z_index = 200
	get_node("AnimatedSprite").play("explode")
	get_node("AnimatedSprite").connect("animation_finished", self, "animation_finished")

func animation_finished():
	queue_free()
	