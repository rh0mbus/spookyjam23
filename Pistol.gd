extends Sprite2D

func fire():
	$AnimationPlayer.play("fire")
	$AudioStreamPlayer.play()
