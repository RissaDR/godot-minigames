extends Camera2D

var shake_amount = 5
var isshaking
var scrshcount = 0
var scrduration = 0.5


func _ready():
	current = true
	isshaking = 0
	
func _process(delta):
	if isshaking == 1:
		set_offset(Vector2( \
	        rand_range(-1.0, 1.0) * shake_amount, \
	        rand_range(-1.0, 1.0) * shake_amount \
	    ))
	else:
		set_offset(Vector2(0,0))
	scrshcount += delta
	if scrshcount >= scrduration:
		isshaking = 0

func scrsh(shake):
	shake_amount = shake
	isshaking = 1
	scrshcount = 0
	
	