extends Particles2D

func set_level(level):
	self.material.set_shader_param("level", level)