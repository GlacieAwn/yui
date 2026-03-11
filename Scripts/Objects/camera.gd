extends Camera2D

@export var map: TileMapLayer
@export var target: CharacterBody2D

var tile_size

# TODO: Implement Camera Functionality
func _ready() -> void:
	
	make_current()
	

func _process(_delta: float) -> void:
	if map == null:
		return

	if target == null:
		return

	var map_width = map.get_map_size.width()
	var map_height = map.get_map_size().height()

	var left_edge = 0
	var right_edge = map_width * tile_size
	var top_edge = 0
	var bottom_edge = map_height * tile_size

	clamp(position.x, left_edge, right_edge)
	clamp(position.y, top_edge, bottom_edge)

	self.position = target.global_position
