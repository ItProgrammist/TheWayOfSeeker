extends Area2D




func _on_body_entered(body):
	if body.name == "Seeker":
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 25), 0.3)
		tween1.tween_property(self, "modulate:a", 0, 0.3)
		Global.gold += 1
		tween.tween_callback(queue_free)
