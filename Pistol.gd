extends Sprite2D

func fire():
	$AnimationPlayer.play("fire")
	$AudioStreamPlayer.play()

func unequip():
	self.visible = false

func equip():
	self.visible = true
