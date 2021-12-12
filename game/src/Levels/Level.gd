extends Node

var level_name : String

var PLAYER_PATH = preload("res://src/Actors/Player/Player.tscn")

func _ready() -> void:
	level_name = self.name
	print(level_name)
	var player = PLAYER_PATH.instance()
	add_child(player)
	player.global_position = Vector2(50, 0)
	