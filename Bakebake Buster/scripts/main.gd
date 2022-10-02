extends Node

var score = 0
var bakebakeSpawnRate = 2
var bakebakeSpawnCounter = 0
var bakebakeSpawnLocation = Vector2()
var bakebakeLeft = load("res://scenes/BakebakeLeft.tscn")
var bakebakeRight = load("res://scenes/BakebakeRight.tscn")
var paths
var pathschoose

func _ready():
	bakebakeSpawnCounter = 0
	get_tree().paused = false

func _process(delta):
	paths = [$Path2DLeft/PathFollow2D, $Path2DRight/PathFollow2D]
	get_node("ScoreOnTop/Score").text = str(score)
	pathschoose = paths[randi() % paths.size()]
	pathschoose.set_offset(randi())
	bakebakeSpawnLocation = pathschoose.position
	bakebakeSpawnCounter += delta
	bakebakeSpawnRate -= delta/50
	if bakebakeSpawnCounter >= bakebakeSpawnRate:
		if pathschoose == $Path2DLeft/PathFollow2D:
			bakebakeSpawnLeft()
		elif pathschoose == $Path2DRight/PathFollow2D:
			bakebakeSpawnRight()
		bakebakeSpawnCounter = 0


func bakebakeSpawnLeft():
	var bakebake_instance = bakebakeLeft.instance()
	bakebake_instance.set_name("BakebakeLeft")
	bakebake_instance.position = bakebakeSpawnLocation
	add_child(bakebake_instance)
	bakebake_instance.connect("killed", self, "bakebakeBurst")

func bakebakeSpawnRight():
	var bakebake_instance = bakebakeRight.instance()
	bakebake_instance.set_name("BakebakeRight")
	bakebake_instance.position = bakebakeSpawnLocation
	add_child(bakebake_instance)
	bakebake_instance.connect("killed", self, "bakebakeBurst")
	
func bakebakeBurst():
	score += 1