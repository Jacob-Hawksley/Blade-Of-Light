extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D # Or $AnimatedSprite2D if that's what you're using



const SPEED = 100
const JUMP_VELOCITY = -200

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Global.player.x == null:
		return
	if Global.player.x > position.x:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
