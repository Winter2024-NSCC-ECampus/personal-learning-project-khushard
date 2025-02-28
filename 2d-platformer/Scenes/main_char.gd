extends CharacterBody2D

const SPEED = 375.0
const JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synded with RigidBody Nodes.
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite_2d = $Sprite2D

func _physics_process(delta):
	
	if abs(velocity.x) > 1.0:
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "jumping"
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 5)
	
	move_and_slide()
	
	# Flip sprite based on direction
	var is_left = velocity.x < 0
	sprite_2d.flip_h = is_left
