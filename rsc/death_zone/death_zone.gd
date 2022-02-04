extends Area

func _on_death_zone_body_entered(body):
	if body.name == "ball":
		get_tree().reload_current_scene()
