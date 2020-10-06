extends TileMap

func set_level(level):
	self.material.set_shader_param("level", level)