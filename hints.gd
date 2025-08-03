extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play('none')
	play('jump')
	await get_tree().create_timer(8).timeout
	play('attack')
	await get_tree().create_timer(8).timeout
	play('none')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
