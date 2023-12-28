extends Area2D

# If player enters spike area then game over
func _on_body_entered(body):
	if body.is_in_group("Player"):
		body._game_over()
