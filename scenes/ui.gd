extends CanvasLayer

func disable_interact_text():
	$InteractText/VBoxContainer/Label.visible = false
	
func enable_interact_text():
	$InteractText/VBoxContainer/Label.visible = true
