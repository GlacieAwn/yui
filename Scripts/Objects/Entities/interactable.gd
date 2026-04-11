class_name Interactable extends StaticBody2D

@export var dialogue: String
var is_enabled: bool = true
var can_trigger_cutscene: bool = false




func on_interact() -> void:
	handle_dialogue()
	if Dialogic.current_timeline != null:
		return

func handle_dialogue() -> void:
	if dialogue.strip_edges().is_empty():
		return
	
	var timeline: DialogicTimeline = DialogicTimeline.new()
	timeline.from_text("Yui: " + self.dialogue)
	Dialogic.start(timeline)


	print("Yui: " + self.dialogue) # test
