extends Node2D

@export var speed: float = 120.0
@export var is_reversed: bool = false
var direction: Vector2 = Vector2.RIGHT

func _ready():
	if is_reversed:
		direction = Vector2.LEFT
		$Sprite2D.flip_h = true

func _physics_process(delta):
	position += delta * speed * direction

func _on_lifespan_timeout():
	queue_free()
