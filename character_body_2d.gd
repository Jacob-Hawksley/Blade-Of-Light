extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D 
@onready var _animated_sprite = $AnimatedSprite2D
@onready var busy = 0
@onready var hit = false
@onready var parrycd = 0
@onready var attackcd = 0

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

func _ready() -> void:
	Global.direct = 1
	Global.parry = 0
	Global.counter = 0






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
	if direction != 0 and busy == 0:
		Global.playeraction = "run"
		_animated_sprite.play("run")
	if direction == 0 and busy == 0:
		Global.playeraction = "default"
		_animated_sprite.play("default")
	Global.player = position
	#Attacking
	if Input.is_action_just_pressed("ui_attack") and attackcd == 0:
		Global.playeraction = "attack"
		busy = 1
		attackcd = 1
		_animated_sprite.play("sslash")
		await get_tree().create_timer(0.6).timeout
		busy = 0
		await get_tree().create_timer(0.5).timeout
		attackcd = 0
	#parrying
	if Input.is_action_just_pressed("ui_parry") and parrycd == 0:
		Global.playeraction = "parry"
		busy = 1
		parrycd = 1
		_animated_sprite.play("parryready")
		Global.parry = 1
		await get_tree().create_timer(0.3).timeout
		if hit == true:
			Global.counter = 1
			_animated_sprite.play("parryyes")
			await get_tree().create_timer(0.01).timeout
			busy = 0
			parrycd = 0
			Global.parry = 0
			
		elif hit == false:
			Global.parry = 0
			busy = 0
			await get_tree().create_timer(1).timeout
			parrycd = 0
		
		
		
	if Global.hp <= 0:
		position.x = -500
		position.y = 8
		Global.hp = 5
	if Global.counter == 1:
		await get_tree().create_timer(1.1).timeout
		Global.counter = 0
	move_and_slide()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	hit = true
	await get_tree().create_timer(0.3).timeout
	hit = false
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.hp -= 1
	position.y = 8
	position.x = -500
	



	


func _on_heartbox_area_entered(area: Area2D) -> void:
	Global.hp = 5
	
