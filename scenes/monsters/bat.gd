extends Node2D

@export var speed: float = 50.0
var direction: Vector2 = Vector2.RIGHT

func _ready():
	pass

func _physics_process(delta):
	position += delta * speed * direction

