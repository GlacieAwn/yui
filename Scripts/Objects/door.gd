extends Interactable

# @export var scene_to_change_to: PackedScene # TO BE USED LATER

func on_interact() -> void:
	handle_dialogue()

	if self.is_in_group("Door"):
		#TODO: Play the door sound effect if the object is in group door, to prevent it playing when the object is a loading zone instead(NOT IMPORTANT, BUT WILL BE IMPORTANT LATER)
		pass