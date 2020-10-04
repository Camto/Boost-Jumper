extends TileMap

const AREA_TILE = 0

func _ready():
	for cell in get_used_cells_by_id(AREA_TILE):
		var new_area = Area2D.new()
		new_area.global_position = to_global(map_to_world(cell))
		add_child(new_area)