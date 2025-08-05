extends AnimatedSprite2D
@onready var BeamLeft: Sprite2D = $LaserBeams/BeamLeft
@onready var BeamLeftC: CollisionShape2D = $LaserBeams/BeamLeft/Left/CollisionShape2D
@onready var BeamRight: Sprite2D = $LaserBeams/BeamRight
@onready var BeamRightC: CollisionShape2D = $LaserBeams/BeamRight/Right/CollisionShape2D
@onready var BeamMiddle: Sprite2D = $LaserBeams/BeamMiddle
@onready var BeamMiddleC: CollisionShape2D = $LaserBeams/BeamMiddle/Middle/CollisionShape2D

func _ready() -> void:
	BeamLeftC.disabled = true
	BeamRightC.disabled = true
	BeamMiddleC.disabled = true
	BeamLeft.visible = false
	BeamRight.visible = false
	BeamMiddle.visible = false
	while true:
		play('default')
		await get_tree().create_timer(0.3).timeout
		play('left')
		await get_tree().create_timer(0.3).timeout
		BeamLeft.visible = true
		BeamLeftC.disabled = false
		await get_tree().create_timer(2).timeout
		BeamLeft.visible = false
		BeamLeftC.disabled = true
		play('default')
		await get_tree().create_timer(0.3).timeout
		play('right')
		await get_tree().create_timer(0.3).timeout
		BeamRight.visible = true
		BeamRightC.disabled = false
		await get_tree().create_timer(2).timeout
		BeamRight.visible = false
		BeamRightC.disabled = true
		play('default')
		await get_tree().create_timer(0.3).timeout
		play('middle')
		await get_tree().create_timer(0.3).timeout
		BeamMiddle.visible = true
		BeamMiddleC.disabled = false
		await get_tree().create_timer(2).timeout
		BeamMiddle.visible = false
		BeamMiddleC.disabled = true
		
