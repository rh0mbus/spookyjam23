extends Area2D

signal player_opened_safe

var is_openable: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if is_openable and "change_rooms" in body:
		is_openable = false
		player_opened_safe.emit()
		$OpenSoundStreamPlayer.play()
