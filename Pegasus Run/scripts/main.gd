extends Node

# Chromekoma Pegasus
# Pegasus run.
# Meeting again after a long time, Saki invites Miko to the Beast Realm.
# Copy of the Chrome Dino.
# The dinosaur is replaced by 
# The background is the Primate Garden.
# Buildings are scrolled by.
# The cactus are replaced by haniwa, in random clusters
# The birds that appear later in the Chrome Dino game are replaced by beast spirits.
# Otter spirits stay low.
# Eagle spirits fly high.

#Terrain

var level = 1 # emit signal and descrease rate per level
			# add eagle and otter when level
			# increase speed
var score
var obstacleAddRate = 2
var obstacleRateRandomise = [2, 3]
var obstacleAddCounter = 0
var haniwa1 = load("res://scenes/Haniwa1.tscn")
var haniwa2 = load("res://scenes/Haniwa2.tscn")
var haniwa3 = load("res://scenes/Haniwa3.tscn")
var eagle = load("res://scenes/Eagle.tscn")
var otter = load("res://scenes/Otter.tscn")
var obstacle = [haniwa1, haniwa2]
var randomise
var nextObstacle
var obstacleInstance
signal levelSet
signal milestone


func _ready():
	get_tree().paused = false
	level = 1
	score = 0
	obstacleAddRate = 2
	connect("levelSet", self, "levelSet")
	connect("milestone", get_node("milestone_sfx"), "milestone")
	
func _process(delta):
	get_node("Score").text = str(score)
	obstacleAddRate = rand_range(obstacleRateRandomise[0], obstacleRateRandomise[1])
	score += 1
	obstacleAddCounter += delta
	if obstacleAddCounter > obstacleAddRate:
		obstacleSpawn()
	get_node("Score").text = str(score)
	if score % 1000 == 0:
		emit_signal("milestone")
	if score >= 8000:
		level = 9
		emit_signal("levelSet", level)
	elif score >= 7000:
		level = 8
		emit_signal("levelSet", level)
	elif score >= 6000:
		level = 7
		emit_signal("levelSet", level)
	elif score >= 5000:
		level = 6
		emit_signal("levelSet", level)
	elif score >= 4000:
		level = 5
		emit_signal("levelSet", level)
	elif score >= 3000:
		level = 4
		emit_signal("levelSet", level)
	elif score >= 2000:
		level = 3
		emit_signal("levelSet", level)
	elif score >= 1000:
		level = 2
		emit_signal("levelSet", level)
	elif score >= 0:
		level = 1
		emit_signal("levelSet", level)
		
func obstacleSpawn():
	obstacleAddCounter = 0
	randomise = randi() % len(obstacle)
	nextObstacle = obstacle[randomise]
	obstacleInstance = nextObstacle.instance()
	obstacleInstance.name = "obstacle"
	add_child(obstacleInstance)
	connect("levelSet", obstacleInstance, "levelSet")

func levelSet(level):
	if level == 1:
		obstacleRateRandomise = [2, 3]
	if level == 2:
		obstacle = [haniwa1, haniwa2, haniwa3]
	if level == 3:
		obstacleRateRandomise = [1, 2]
	if level == 5:
		obstacleRateRandomise = [0.8, 1.5]
	if level == 6:
		obstacle = [haniwa1, haniwa2, haniwa3, otter]
	if level == 7:
		obstacle = [haniwa1, haniwa2, haniwa3, otter, eagle]
	if level == 8:
		obstacleRateRandomise = [0.7, 1.4] 