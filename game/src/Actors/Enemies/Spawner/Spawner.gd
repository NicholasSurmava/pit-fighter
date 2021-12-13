extends StaticBody2D

var HP setget set_hp, get_hp

func _ready() -> void:
	print(name + " is ready")
	
	print(Autoload.enemies_per_level["level_1"])

func get_hp():
	return HP
	
func set_hp(new_hp):
	HP = new_hp
