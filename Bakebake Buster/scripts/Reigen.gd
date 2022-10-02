extends KinematicBody2D

signal ReigenIsSafe
signal ReigenDied
signal bakebakeIsNear

func _ready():
	$AnimatedSprite.play("sweat")
	connect("ReigenDied", get_tree().get_root().get_node("Control/Node/DeathOnTop/ReigenDied"), "ReigenDied")
	connect("bakebakeIsNear", get_tree().get_root().get_node("Control/Node/AudioStreamPlayer"), "bakebakeIsNear")
	connect("ReigenIsSafe", get_tree().get_root().get_node("Control/Node/AudioStreamPlayer"), "ReigenIsSafe")
	connect("ReigenDied", get_tree().get_root().get_node("Control/Node/AudioStreamPlayer"), "ReigenDied")

func _process(delta):
	var death = get_node("Hitbox").get_overlapping_areas()
	if len(death) > 0:
		emit_signal("ReigenDied")
		get_tree().paused = true
	var bakebakeNear = get_node("PersonalSpace").get_overlapping_areas()
	if len(bakebakeNear) > 0:
		$AnimatedSprite.play("WAA")
		emit_signal("bakebakeIsNear")
	else:
		$AnimatedSprite.play("sweat")
		emit_signal("ReigenIsSafe")
	
		