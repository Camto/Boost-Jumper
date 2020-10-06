extends Area2D

var used = false

func _on_Lavaball_body_entered(body):
	if body.name == "Player" and not used:
		body.upgrade()
		self.hide()
		used = true