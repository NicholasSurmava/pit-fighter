extends Node

func _ready() -> void:
	# TODO: Randomly determine the number of enemies per level. 5-15 enemies.
	# Add to Autoload script as singleton.
	
	# The spawners can then grab and spawn until they hit the limit.
	var enemies_per_level = random_enemy_generator(4)
	Autoload.enemies_per_level = enemies_per_level
	print(get_enemy_count("Level_1"))
	
	return

func _process(delta):
	$CanvasLayer/Score.text = str(Autoload.SCORE_SYSTEM)
	$CanvasLayer/Score.text = "Enemies Left: " + str(get_enemy_count("Level_1"))
	
	if get_enemy_count("Level_1") == 0:
		$CanvasLayer/Score.text = "Level 1 complete"

func random_enemy_generator(levels):
	# Takes in the number of levels and generators an int based on the number of levels passed in.
	var enemies_to_generate = {}
	
	for level in levels:
		randomize()
		var number_of_enemies = randi() % 10 + 5
		enemies_to_generate["level_" + str(level + 1)] = number_of_enemies
		
	return enemies_to_generate

func get_enemy_count(level):
	return get_node(level).get_node("Enemies").get_child_count()
