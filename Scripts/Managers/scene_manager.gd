extends Node

var scene_instance: Node

func _ready() -> void:
	Global.scene_manager = self

# Loads a scene with the given path, and decide whether to hide or delete the current scene depending on the input of `free`. 
# If free is true, then the scene is deleted, only getting loaded again when called. If false, then the scene is merely hidden. This is useful for menus, where the current scene might not need to be completely destroyed as you might need to go back to it. 
func load_scene_from_path(path: String, free: bool) -> Node:
	# Handle the previous scene instance
	if scene_instance:
		if free:
			# Delete the scene if free is true
			scene_instance.queue_free()
			await get_tree().process_frame
		else:
			# Hide the scene if free is false
			scene_instance.hide()

	# Load the scene file from the given path
	var loaded_scene = ResourceLoader.load(path)
	# Exit early if the scene failed to load
	assert(loaded_scene != null, "Failed to load scene")
	if loaded_scene == null:
		return null
	
	# Create an instance of the loaded scene
	scene_instance = loaded_scene.instantiate()
	# Return the new scene instance
	return 
	
# Loads a scene resource and decides whether to hide or delete the current scene
# depending on the input of `free`.
# If free is true, then the scene is deleted, only getting loaded again when called. If false, then the scene is merely hidden. This is useful for menus, where the current scene might not need to be completely destroyed as you might need to go back to it. 
func load_scene_from_resource(scene: PackedScene, free: bool) -> Node:
	# Handle the previous scene instance
	if scene_instance:
		if free:
			# Delete the scene if free is true
			scene_instance.queue_free()
			await get_tree().process_frame
		else:
			# Hide the scene if free is false
			scene_instance.hide()

	# Exit early if the scene resource is missing
	assert(scene != null, "Failed to load scene")
	if scene == null:
		return null
	
	# Create an instance of the provided scene resource
	scene_instance = scene.instantiate()
	# Return the new scene instance
	return scene_instance