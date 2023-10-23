extends Sprite2D

var smoothed_mouse_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	smoothed_mouse_pos = lerp(smoothed_mouse_pos, get_global_mouse_position(), 0.05)
	look_at(smoothed_mouse_pos)
