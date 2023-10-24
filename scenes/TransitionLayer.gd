extends CanvasLayer

func _ready():
	pass


func fade_in():
	$AnimationPlayer.play("fade-in")

func fade_out():
	$AnimationPlayer.play_backwards("fade-in")

func in_out():
	$AnimationPlayer.play("in-out")
