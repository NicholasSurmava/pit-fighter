extends Node

var level_name : String

func _ready() -> void:
	level_name = self.name
	print(level_name)
