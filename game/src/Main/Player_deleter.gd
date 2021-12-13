extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_deleter_body_entered(body):
	if body.name == "Player":
		body.queue_free()
		yield(get_tree().create_timer(0.5), "timeout")
		get_parent().get_parent().get_node("Title").visible = true
		get_parent().get_parent().get_node("Title_Background").visible = true
		yield(get_tree().create_timer(4), "timeout")
		print("Change level")
		get_tree().change_scene("res://src/Levels/Level_1.tscn")
