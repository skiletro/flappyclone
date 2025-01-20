extends CharacterBody2D

var isAlive = true
const JUMP_VELOCITY = -300.0

@onready var originalPosition = position
@onready var originalRotation = rotation

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("flap") and isAlive and position.y > 0:
		velocity.y = JUMP_VELOCITY
		rotation = deg_to_rad(-25)
		$AudioStreamPlayer.play()
		
	# Rotate downwards when falling
	if rotation <= deg_to_rad(90) and velocity.y > 0 and not is_on_floor():
		rotate(0.08)
		
	# Stop the rotation from overshooting
	if rotation > deg_to_rad(90):
		rotation = deg_to_rad(90)

	move_and_slide()

func reset() -> void:
	isAlive = true
	position = originalPosition
	rotation = originalRotation
	velocity = Vector2(0, 0)
