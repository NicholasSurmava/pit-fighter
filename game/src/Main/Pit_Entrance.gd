extends Area2D

onready var BROKEN_FLOORS = get_parent().get_node("BrokenFloorsIntro")
#onready var LEVEL_1_CAMERA = get_parent().get_parent().get_node("Level_1/Camera2D")

func _on_Pit_Entrance_body_entered(body):
	if body.name == "Player":
		print("starting level 1")
		BROKEN_FLOORS.visible = false
		BROKEN_FLOORS.collision_layer = 0
		BROKEN_FLOORS.collision_mask = 0
