extends Interactable


func on_interact() -> void:
	handle_dialogue()
	#TODO: Check for chest content and add item to player's inventory when opened