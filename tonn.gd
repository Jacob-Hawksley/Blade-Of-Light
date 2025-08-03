extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flip_v = false
	while true:
		play("left")
		for i in range(10):
			position.x -= 7
			await get_tree().create_timer(0.1).timeout
		await get_tree().create_timer(0.6).timeout
		play("right")
		for i in range(10):
			position.x += 7
			await get_tree().create_timer(0.1).timeout
		await get_tree().create_timer(0.6).timeout


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	flip_v = true
	await get_tree().create_timer(0.1).timeout
	queue_free()
