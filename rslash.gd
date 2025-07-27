extends CollisionShape2D




func _on_animated_sprite_2d_animation_finished() -> void:
	if Global.direct > 0:
		self.disabled = false
		await get_tree().create_timer(0.1).timeout
		self.disabled = true
	else:
		self.disabled = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.ravenhit = true
	await get_tree().create_timer(0.1).timeout
	Global.ravenhit = false
