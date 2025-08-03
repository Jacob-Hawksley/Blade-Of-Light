extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D 
@onready var ravenhp = 20
@onready var iframe = 0
@onready var bar: ProgressBar = $Hp
@onready var cd = 0
@onready var poisebar: ProgressBar = $Poise
@onready var poisecd = 0
@onready var poisetimer = 0
@onready var poiseinterval = 0
@onready var poisetimerdetector = 0
@onready var move = 0
@onready var attacking = false


func _ready() -> void:
	while true:
		if cd == 0 and attacking == false and poisebar.value < 100:
			var choice = randi() % 2
			if choice == 0:
				for i in range(10):
					position.x += 5
					await get_tree().create_timer(0.1).timeout
				for i in range(10):
					position.x -= 5
					await get_tree().create_timer(0.1).timeout
				
				

		await get_tree().create_timer(0.01).timeout


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
	if (position.x - 200) < Global.player.x and Global.player.x < (position.x + 200) and attacking == false and cd == 0 and poisebar.value < 100:
		attacking = true
		await get_tree().create_timer(randfn(2,1)).timeout
		cd = 1
		sprite.play('spin')
		Global.currentattack = "spin"
		await get_tree().create_timer(1).timeout
		Global.currentattack = null
		cd = 0
		attacking = false
		
		
	if Global.player == null:
		return
	if Global.ravenhit == true:
		if iframe == 0:
			if poisebar.value >= 100:
				ravenhp -= 20
			elif Global.counter == 1:
				ravenhp -= 1
				poisebar.value += (15)
			elif Global.counter == 0:
				ravenhp -= 1
				poisebar.value += (8)
			iframe = 1
			poisetimer = 20
			await get_tree().create_timer(0.2).timeout
			iframe = 0
	bar.value = ravenhp
	
	if poisetimer > 0 and poiseinterval == 0:
		poiseinterval = 1
		poisecd = 1
		await get_tree().create_timer(0.1).timeout
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
		
	 
