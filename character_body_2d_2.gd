extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D # Or $AnimatedSprite2D if that's what you're using
@onready var ravenhp = 15
@onready var iframe = 0
@onready var bar: ProgressBar = $Hp
@onready var a = 0
@onready var cd = 0

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
	Global.raven = int(self.position.x)
	
	bar.value = ravenhp
	if cd == 0:
		sprite.play('default')
	if a == 1 and cd == 0:
		cd = 1
		await get_tree().create_timer(randfn(0,3)).timeout
		sprite.play('spin')
		await get_tree().create_timer(1).timeout
		cd = 0
		a = 0
	if Global.player == null:
		return
	if (position.x - 200) < Global.player.x and Global.player.x < (position.x + 200) and cd == 0:
		await get_tree().create_timer(0.5).timeout
		a = randi() % 5
		
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if iframe == 0:
		iframe = 1
		ravenhp -= 1 
		await get_tree().create_timer(0.3).timeout
		iframe = 0
	 
