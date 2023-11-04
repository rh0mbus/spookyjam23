extends CharacterBody2D


const SPEED = 7.75
const ACCELERATION = 1.2
const FRICTION = 2.0

var is_alive: bool = true
var is_able_to_move: bool = true
var is_moving: bool = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var possible_dir = [Vector2.LEFT.x, Vector2.RIGHT.x]
var direction = Vector2.LEFT.x

func _process(_delta):

	if is_able_to_move:
		do_zombie_movement()
		is_able_to_move = false

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

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
