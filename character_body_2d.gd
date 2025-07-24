extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D 
@onready var _animated_sprite = $AnimatedSprite2D
@onready var cd = 0

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

func _ready() -> void:
	Global.z = 0
	Global.direct = 1
	






func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	

	# --- New Sprite Flipping Logic ---
	if direction < 0: # Moving left
		sprite.flip_h = true
		Global.direct = -1 # Flip horizontally
	elif direction > 0: # Moving right
		sprite.flip_h = false
		Global.direct = 1 # Unflip horizontally
	# --- End New Sprite Flipping Logic ---

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#Running and walking
	if direction != 0 and Global.z == 0:
		_animated_sprite.play("run")
	if direction == 0 and Global.z == 0:
		_animated_sprite.play("default")
	Global.player = position
	#Attacking
	if Input.is_key_pressed(KEY_Z) and cd == 0:
		cd = 1
		Global.z = 1
		_animated_sprite.play("sslash")
		await get_tree().create_timer(0.6).timeout
		Global.z = 0
		await get_tree().create_timer(0.5).timeout
		cd = 0
		
	move_and_slide()
