extends StaticBody2D

var HP setget set_hp, get_hp
export var ENEMY_TYPE : String

func _ready() -> void:
	print(name + " is ready")
	print("Spawning " + ENEMY_TYPE + " types.")
	
	
	print(Autoload.enemies_per_level["level_1"])
#	for count in (Autoload.enemies_per_level["level_1"] / 2):
	for count in 3:
		var enemy_to_spawn = load(ENEMY_TYPE).instance()
		get_tree().root.add_child(enemy_to_spawn)
		enemy_to_spawn.global_position = self.global_position
		print("spawned enemy # " + str(count))
		yield(get_tree().create_timer(0.7), "timeout")

func get_hp():
	return HP
	
func set_hp(new_hp):
	HP = new_hp
