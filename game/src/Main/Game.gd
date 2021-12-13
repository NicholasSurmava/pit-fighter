extends Node

func _ready() -> void:
	# TODO: Randomly determine the number of enemies per level. 5-15 enemies.
	# Add to Autoload script as singleton.
	
	# The spawners can then grab and spawn until they hit the limit.
	var enemies_per_level = random_enemy_generator(4)
	Autoload.enemies_per_level = enemies_per_level
#	print(get_enemy_count("Level_1"))
	
	return

func random_enemy_generator(levels):
	# Takes in the number of levels and generators an int based on the number of levels passed in.
	var enemies_to_generate = {}
	
	for level in levels:
		randomize()
		var number_of_enemies = randi() % 40 + 2
		enemies_to_generate["level_" + str(level + 1)] = number_of_enemies
		
	return enemies_to_generate

#func get_enemy_count(level):
#	return get_node(level).get_node("Enemies").get_child_count()
