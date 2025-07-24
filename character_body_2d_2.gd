extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D # Or $AnimatedSprite2D if that's what you're using
@onready var ravenhp = 15
@onready var iframe = 0


func _process(delta: float) -> void:
	pass


const SPEED = 100
const JUMP_VELOCITY = -200

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Face the player
	if Global.player.x == null:
		return
	if Global.player.x > position.x:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	if ravenhp <= 0:
		queue_free()
		
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if iframe == 0:
		iframe = 1
		print('a')
		ravenhp -= 1 
		await get_tree().create_timer(0.3).timeout
		iframe = 0
	 
