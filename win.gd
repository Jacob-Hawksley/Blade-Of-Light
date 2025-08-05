extends AnimatedSprite2D
func _ready() -> void:
	Global.win = false
func _process(delta: float) -> void:
	if Global.win == true:
		play('yes')
	else:
		play('no')
