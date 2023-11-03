extends Area2D

signal health_picked_up(amount: int)

var health_amount: int = 50
var is_picked_up: = false

func _on_body_entered(body):
	if not is_picked_up and "mutate_health" in body:
		health_picked_up.emit(health_amount)
		is_picked_up = !is_picked_up #ensure kill in one frame
		queue_free()
