extends Area2D

export var LEVEL_GOTO : String


func _on_Player_deleter_body_entered(body):
	if body.name == "Player":
		body.queue_free()
		yield(get_tree().create_timer(0.5), "timeout")
		get_tree().change_scene(LEVEL_GOTO)
