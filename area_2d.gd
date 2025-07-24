extends Area2D
@onready var hpcd = 0
func on_body_entered(body):
	print('Body Entered')
	if hpcd == 0:
		hpcd = 1
		Global.ravenhp -= 1
		await get_tree().create_timer(0.4).timeout
		hpcd == 0
	
