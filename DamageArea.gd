extends Area2D

signal damage(damage: int)

@export var damage_amount: int = -25

var is_one_shot: bool = true

func _on_body_entered(body):
	if "mutate_health" in body:
		damage.emit(damage_amount)
	if is_one_shot:
		queue_free()


func _on_life_time_timer_timeout():
	queue_free()
