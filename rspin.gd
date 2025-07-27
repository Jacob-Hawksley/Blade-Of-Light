extends CollisionShape2D




func _on_animated_sprite_2d_animation_finished() -> void:
	if Global.currentattack == "spin":
		if Global.player == null:
			return
		if Global.player.x > Global.raven:
			self.disabled = false
			await get_tree().create_timer(0.1).timeout
			self.disabled = true
		else:
			self.disabled = true
