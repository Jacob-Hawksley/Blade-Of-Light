extends CollisionShape2D
func _process(delta: float) -> void:
	pass


func _on_hurtbox_area_entered(area: Area2D) -> void:
	Global.hp -= 1


func _on_animated_sprite_2d_animation_finished() -> void:
	if Global.player == null:
		return
	if Global.player.x < Global.raven:
		print('a')
		
		self.disabled = false
		await get_tree().create_timer(0.1).timeout
		self.disabled = true
	else:
		self.disabled = true
