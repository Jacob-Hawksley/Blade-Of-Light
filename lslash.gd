extends CollisionShape2D
func _process(delta: float) -> void:
	if Global.direct < 0 and Global.z == 1:
		await get_tree().create_timer(0.3).timeout
		self.disabled = false
		
	else:
		self.disabled = true
