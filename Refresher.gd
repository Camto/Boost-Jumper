extends Area2D

func _on_Refresher_body_entered(body):
	if body.name == "Player":
		body.refresh()