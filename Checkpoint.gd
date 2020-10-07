extends Area2D

func _on_Checkpoint_body_entered(body):
	if body.name == "Player":
		body.checkpoint($Spawnpoint.global_position)