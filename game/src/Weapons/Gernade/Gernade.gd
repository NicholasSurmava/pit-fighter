extends RigidBody2D

var direction : Vector2 = Vector2.ZERO

var ENEMIES_TO_BLOW_UP = []

func _ready():
	print("Gernade Popped!")

func _physics_process(delta):
	linear_velocity.x = direction.x * 10


func _on_BombRadius_body_entered(body):
	# Get the enemies that enter the bomb radius, add to array
	if body.is_in_group("enemy"):
		print("ADDING")
		ENEMIES_TO_BLOW_UP.append(body)


func _on_BombRadius_body_exited(body):
	# Remove enemies that LEAVE the bomb radius
	
	if body.is_in_group("enemy"):
		print("REMOVING")
		ENEMIES_TO_BLOW_UP.erase(body)


func _on_Timer_timeout():
	$BombRadius/boom.visible = true
	yield(get_tree().create_timer(0.3), "timeout")
	print(ENEMIES_TO_BLOW_UP)
	print("BOOM")
	for enemy in ENEMIES_TO_BLOW_UP:
		print("Blew up " + enemy.name)
		enemy.queue_free()
	self.queue_free()
