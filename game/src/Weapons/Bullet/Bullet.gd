extends KinematicBody2D

var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO

signal hit

func _physics_process(delta):
	velocity.x = direction.x * 500
	
	velocity = move_and_slide(velocity)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.collider
		if collider.name == "MapTiles":
			queue_free()
			
		if collider.is_in_group("enemy"):
			self.queue_free()
			collider.queue_free()
			Autoload.SCORE_SYSTEM += 10
			
		if collider.is_in_group("spawner"):
			print(collider)
			self.connect("hit", collider, "on_Bullet_hit")
			emit_signal("hit")
			self.queue_free()
			Autoload.SCORE_SYSTEM += 20
			
		


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
