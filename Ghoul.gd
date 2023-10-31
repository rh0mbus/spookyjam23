extends Node2D

func _ready():
	$AnimationPlayer.play("appear")
	await $BlinkTimer.timeout
	$AnimationPlayer.play("blink")
	await $FadeTimer.timeout
	$AnimationPlayer.play("disappear")

func disappear():
	queue_free()
