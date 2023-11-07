extends Node2D

func _ready():
	$BloodCPUParticles2D.emitting = true

func _on_timer_timeout():
	queue_free()
