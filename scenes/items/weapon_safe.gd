extends Area2D

signal player_opened_safe

var is_openable: bool = true

func _on_body_entered(body):
	if is_openable and "change_rooms" in body:
		is_openable = false
		player_opened_safe.emit()
		$OpenSoundStreamPlayer.play()
