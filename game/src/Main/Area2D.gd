extends Area2D

func _on_IntroChar_body_entered(body):
	if body.name == "Player":
		$Dialogue.visible = true
		yield(get_tree().create_timer(5), "timeout")
		$Dialogue.visible = false
