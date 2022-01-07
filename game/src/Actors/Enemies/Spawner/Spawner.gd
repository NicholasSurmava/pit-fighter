extends StaticBody2D

var HP = 3 setget set_hp, get_hp
var MAX_HP
export var ENEMY_PATH : String
var enemy_count = 3

func _ready() -> void:
	MAX_HP = HP
	print(name + " is ready")
	
	spawn_enemy()
	
func _process(delta):
	$Label.text = str(HP) + '/' + str(MAX_HP)
	
	if HP == 0:
		self.queue_free()

func spawn_enemy():
	enemy_count = random_enemy_generator()
	if enemy_count != 0:
		for count in enemy_count:
			var enemy = load(ENEMY_PATH).instance()
			print(self.name +  " spawning enemy #" + str(count))
			get_tree().root.get_node("Level").get_node("Enemies").add_child(enemy)
			enemy.global_position = self.global_position
			yield(get_tree().create_timer(1), "timeout")

func get_hp():
	return HP
	
func set_hp(new_hp):
	HP = new_hp

func on_Bullet_hit():
	print("Bullet hit")
	if HP > 0:
		HP -= 1
		
func random_enemy_generator():
	randomize()
	var number_of_enemies = randi() % 10 + 2
		
	return number_of_enemies

