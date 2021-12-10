extends KinematicBody2D

var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO

var FACING

func _ready() -> void:
	direction.x = 1
	FACING = direction.x
	
func _physics_process(delta) -> void:
	"""
	Create enemy logic to go from left to right when it hits wall.
	"""
	velocity.y += 1000 * delta
	
	velocity.x = FACING * 60
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_wall():
		if FACING == 1:
			FACING = -1
		elif FACING == -1:
			FACING = 1
			
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.collider
		if collider.name == "Player":
			# Figure out how to do hit impact, need to bounce player off the enemy in the opposite 
			# direction when hit
			print("OUCH")
	
