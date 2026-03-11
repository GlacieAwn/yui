extends Camera2D

@export var map: TileMapLayer
@export var target: CharacterBody2D

var map_min: Vector2 = Vector2.ZERO
var map_max: Vector2 = Vector2.ZERO


func _ready() -> void:
	make_current()
	clamp_camera()


func _process(_delta: float) -> void:
	if map == null:
		return

	if target == null:
		return

	global_position = target.global_position


func clamp_camera() -> void:
	if map == null:
		return

	if map.tile_set == null:
		return

	var used_rect = map.get_used_rect()

	var cell_size: Vector2 = Vector2(map.tile_set.tile_size)
	var top_left_local: Vector2 = Vector2(used_rect.position) * cell_size
	var bottom_right_local: Vector2 = Vector2(used_rect.position + used_rect.size) * cell_size

	var top_left_world: Vector2 = map.to_global(top_left_local)
	var bottom_right_world: Vector2 = map.to_global(bottom_right_local)

	map_min = Vector2(
		min(top_left_world.x, bottom_right_world.x),
		min(top_left_world.y, bottom_right_world.y)
	)
	map_max = Vector2(
		max(top_left_world.x, bottom_right_world.x),
		max(top_left_world.y, bottom_right_world.y)
	)

	limit_left = int(map_min.x)
	limit_top = int(map_min.y)
	limit_right = int(map_max.x)
	limit_bottom = int(map_max.y)
