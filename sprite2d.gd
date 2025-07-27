extends Sprite2D
@onready var _AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.hp = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.hp == null:
		return
	_AnimatedSprite2D.play(str(Global.hp))
