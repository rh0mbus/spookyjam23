extends CharacterBody2D

signal deal_damage(amount: int)
signal zombie_death

const SPEED = 7.75
const ACCELERATION = 1.2
const FRICTION = 2.0

var health: int = 100

var is_alive: bool = true
var is_able_to_move: bool = true
var is_moving: bool = false

var attack_damage: int  = 50

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var possible_dir = [Vector2.LEFT.x, Vector2.RIGHT.x]
var direction = Vector2.LEFT.x

func _process(_delta):
	
	if is_alive:
		if health <= 0:
			die()

		if is_able_to_move:
			do_zombie_movement()
			is_able_to_move = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_alive:
		if is_moving:
			velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
		else:
			velocity.x = move_toward(velocity.x, 0, FRICTION)

		move_and_slide()

func do_zombie_movement():
	direction = possible_dir.pick_random()
	is_moving = true
	var wait_time = randi_range(1, 3)
	await get_tree().create_timer(wait_time).timeout
	is_moving = false
	await get_tree().create_timer(wait_time).timeout
	is_able_to_move = true

func die():
	$AnimationPlayer.play("death")
	is_alive = false
	is_able_to_move = false
	$CleanupTimer.start()
	await $CleanupTimer.timeout
	queue_free()

func attack():
	deal_damage.emit(attack_damage)

func handle_shot_damage(damage: int):
	health -= damage
