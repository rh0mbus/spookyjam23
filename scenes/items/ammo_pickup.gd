extends Area2D

signal ammo_picked_up(amount: int)

var pistol_ammount = 15
var shotgun_amount = 5
var type_chance: int

func _ready():
	type_chance = randi_range(1, 10)
	if type_chance >= 3:
		$Sprite2D.frame = 0
	else:
		$Sprite2D.frame = 1

func _on_body_entered(body):
	if "change_rooms" in body:
		if type_chance >= 3:
			ammo_picked_up.emit(pistol_ammount)
		else:
			ammo_picked_up.emit(shotgun_amount)
		queue_free()
