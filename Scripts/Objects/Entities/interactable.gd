class_name Interactable extends Area2D

var is_enabled: bool = true
var can_trigger_cutscene: bool = false

enum InteractableType {
	NPC,
	PROP
}

func on_interact() -> void:
	pass