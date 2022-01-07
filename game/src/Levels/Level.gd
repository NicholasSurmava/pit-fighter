extends Node

var level_name : String

var PLAYER_PATH = preload("res://src/Actors/Player/Player.tscn")

onready var BROKEN_FLOORS = get_node("BrokenFloorsIntro")

func _ready() -> void:
	level_name = self.name
	print(level_name)
	var player = PLAYER_PATH.instance()
	add_child(player)
	player.global_position = Vector2(175, 0)
	
func _process(delta):
	check_enemies()
	
func check_enemies():
	if $Spawners.get_child_count() == 0 and $Enemies.get_child_count() == 0:
		BROKEN_FLOORS.visible = false
		BROKEN_FLOORS.collision_layer = 0
		BROKEN_FLOORS.collision_mask = 0
