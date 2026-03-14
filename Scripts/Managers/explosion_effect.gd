extends StaticBody2D

@onready var explosion_animation = $AnimationPlayer

func _ready() -> void:
	explosion_animation.play("explod")
