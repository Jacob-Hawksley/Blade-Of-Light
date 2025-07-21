extends AnimatedSprite2D
@onready var _AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	Global.hp = 5



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_AnimatedSprite2D.play(Global.hp)
