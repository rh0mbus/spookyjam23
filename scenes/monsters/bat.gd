extends Node2D

@export var speed: float = 60.0
var direction: Vector2 = Vector2.RIGHT

func _ready():
	pass

func _physics_process(delta):
	position += delta * speed * direction

func _on_lifespan_timeout():
	queue_free()
