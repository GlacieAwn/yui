extends Camera2D

@export var map: TileMapLayer
@export var target: CharacterBody2D
@export var camera_offset: float = 50.0

var world_min: Vector2 = Vector2.ZERO
var world_max: Vector2 = Vector2.ZERO


func _ready() -> void:
	make_current()
	update_camera_limits()


func _process(_delta: float) -> void:
	if map == null:
		return

	if target == null:
		return

	global_position = target.global_position
	global_position = Vector2(
		clamp(global_position.x, world_min.x, world_max.x),
		clamp(global_position.y, world_min.y, world_max.y)
	)


func update_camera_limits() -> void:
	if map == null:
		return

	if map.tile_set == null:
		return

	var used_rect: Rect2i = map.get_used_rect()
	if used_rect.size == Vector2i.ZERO:
		return

	var cell_size: Vector2 = Vector2(map.tile_set.tile_size)
	var top_left_local: Vector2 = Vector2(used_rect.position) * cell_size
	var bottom_right_local: Vector2 = Vector2(used_rect.position + used_rect.size) * cell_size

	var top_left_world: Vector2 = map.to_global(top_left_local)
	var bottom_right_world: Vector2 = map.to_global(bottom_right_local)

	world_min = Vector2(
		min(top_left_world.x, bottom_right_world.x) + camera_offset,
		min(top_left_world.y, bottom_right_world.y) + camera_offset
	)
	world_max = Vector2(
		max(top_left_world.x, bottom_right_world.x) - camera_offset,
		max(top_left_world.y, bottom_right_world.y) - camera_offset
	)

	limit_left = int(world_min.x)
	limit_top = int(world_min.y)
	limit_right = int(world_max.x)
	limit_bottom = int(world_max.y)
