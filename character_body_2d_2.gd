extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D # Or $AnimatedSprite2D if that's what you're using
@onready var ravenhp = 40
@onready var iframe = 0
@onready var bar: ProgressBar = $Hp
@onready var a = 0
@onready var cd = 0
@onready var poisebar: ProgressBar = $Poise
@onready var poisecd = 0
@onready var poisetimer = 0
@onready var poiseinterval = 0
@onready var poisetimerdetector = 0


func _process(delta: float) -> void:
	pass


const SPEED = 100
const JUMP_VELOCITY = -200

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Face the player
	if poisebar.value < 100:
		if Global.player.x == null:
			return
		if Global.player.x > position.x:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
	if ravenhp <= 0:
		queue_free()
	Global.raven = int(self.position.x)
	
	
	if cd == 0 and poisebar.value < 100:
		sprite.play('default')
	if a == 1 and cd == 0 and poisebar.value < 100:
		cd = 1
		await get_tree().create_timer(randfn(0,3)).timeout
		sprite.play('spin')
		Global.currentattack = "spin"
		await get_tree().create_timer(1).timeout
		Global.currentattack = null
		cd = 0
		a = 0
	if Global.player == null:
		return
	if (position.x - 200) < Global.player.x and Global.player.x < (position.x + 200) and cd == 0:
		await get_tree().create_timer(0.5).timeout
		a = randi() % 5
	if Global.ravenhit == true:
		if iframe == 0:
			if poisebar.value >= 100:
				ravenhp -= 40
			elif Global.counter == 1:
				ravenhp -= 1
				poisebar.value += (4*Global.hp)
			elif Global.counter == 0:
				ravenhp -= 1
				poisebar.value += (2*Global.hp)
			iframe = 1
			poisetimer = 20
			await get_tree().create_timer(0.2).timeout
			iframe = 0
	bar.value = ravenhp
	print('a' + str(poiseinterval))
	
	if poisetimer > 0 and poiseinterval == 0:
		print('b' + str(poiseinterval))
		poiseinterval = 1
		poisecd = 1
		await get_tree().create_timer(0.1).timeout
		print('c' + str(poiseinterval))
		poisetimer -= 1
		poiseinterval = 0
		poisetimerdetector = 0
	
	if poisetimer == 0 and poisetimerdetector == 0:
		poisecd = 0
		poisetimerdetector = 1

	if poisebar.value < 100 and poisebar.value > 0 and poisecd == 0:
		poisecd = 1
		poisebar.value -= 1
		await get_tree().create_timer(0.15).timeout
		poisecd = 0
	

	if poisebar.value >= 100:
		sprite.play('down')
		
	 
