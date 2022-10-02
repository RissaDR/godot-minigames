extends Node

var mineta = preload("res://scenes/Mineta.tscn")
var hitoshi = preload("res://scenes/Hitoshi.tscn")
var pos1 = 128
var pos2 = 256
var pos3 = 384
var sq11 = Vector2(pos1, pos1)
var sq12 = Vector2(pos2, pos1)
var sq13 = Vector2(pos3, pos1)
var sq21 = Vector2(pos1, pos2)
var sq22 = Vector2(pos2, pos2)
var sq23 = Vector2(pos3, pos2)
var sq31 = Vector2(pos1, pos3)
var sq32 = Vector2(pos2, pos3)
var sq33 = Vector2(pos3, pos3)
var sqarray = [sq11, sq12, sq13, sq21, sq22, sq23, sq31, sq32, sq33]
var sqarraylen
var nextsq
var randsq
var minetaAddRate = 2
var minetaAddCounter = 0
var hitoshiAddRate = 6.5
var hitoshiAddCounter = 0
var minetaDeathCount = 0
var hitoshiDeathCount = 0
signal scrsh
signal expelled

func _ready():
	minetaAddCounter = 0
	hitoshiAddCounter = 0
	minetaDeathCount = 0
	connect("expelled", get_node("bar"), "expelled")
	connect("scrsh", get_node("Camera2D"), "scrsh")
	
func _process(delta):
	sqarraylen = len(sqarray)
	if sqarraylen == 0:
		emit_signal("expelled")
	get_node("minetaDeathCount/minetaDeathCount").text = str(minetaDeathCount)
	get_node("hitoshiDeathCount/hitoshiDeathCount").text = str(hitoshiDeathCount)
	if hitoshiDeathCount >= 3:
		emit_signal("expelled")
	minetaAddCounter += delta
	hitoshiAddCounter += delta
	if minetaAddCounter >= minetaAddRate:
		minetaAddCounter = 0
		minetaAdd()
	if hitoshiAddCounter >= hitoshiAddRate:
		hitoshiAddCounter = 0
		hitoshiAdd()
	minetaAddRate -= delta/100
	hitoshiAddRate -= delta/100

func minetaAdd():
	sqarraylen = len(sqarray)
	randsq = randi() % sqarraylen
	nextsq = sqarray[randsq]
	sqarray.remove(randsq)
	instanceMineta(nextsq)
	
func instanceMineta(position):
	var minetaInstance = mineta.instance()
	minetaInstance.set_name("Mineta")
	minetaInstance.position = position
	add_child(minetaInstance)
	
func hitoshiAdd():
	sqarraylen = len(sqarray)
	randsq = randi() % sqarraylen
	nextsq = sqarray[randsq]
	sqarray.remove(randsq)
	instanceHitoshi(nextsq)
	
func instanceHitoshi(position):
	var hitoshiInstance = hitoshi.instance()
	hitoshiInstance.set_name("Hitoshi")
	hitoshiInstance.position = position
	add_child(hitoshiInstance)

func sqIsFree(position):
	sqarray.append(position)

func minetaPew():
	get_node("pewsfx").playing = true
	emit_signal("scrsh", 5)
	minetaDeathCount += 1
	
func hitoshiPew():
	get_node("pewsfx").playing = true
	emit_signal("scrsh", 50)
	hitoshiDeathCount += 1
