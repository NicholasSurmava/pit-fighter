extends KinematicBody2D

var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
var FLOOR_NORMAL : Vector2 = Vector2.UP

var BULLET_PATH = preload("res://src/Weapons/Bullet/Bullet.tscn")

var IS_ON_GROUND

var FACING = 1
var canShoot = true
var shooting = false

func _physics_process(delta):
	if is_on_floor():
		IS_ON_GROUND = true
	else:
		IS_ON_GROUND = false
		
	velocity.x = direction.x * 100

	
	if direction.x > 0:
		$AnimatedSprite.flip_h = false
		FACING = direction.x
	elif direction.x < 0:
		$AnimatedSprite.flip_h = true
		FACING = direction.x
	
	velocity.y += 1000 * delta
	
	dash()
	
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
func _unhandled_input(event):
	get_direction()
	jump()
	jump_cancel()
	shoot()
	
func get_direction():
	direction = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 0)

func jump():
	if Input.is_action_just_pressed("jump") and IS_ON_GROUND:
		velocity.y = -350
	
func jump_cancel():
	if Input.is_action_just_released("jump"):
		if velocity.y < 100:
			velocity.y *= 0.2

func dash():
	if Input.is_action_just_pressed("dash"):
		velocity.x = direction.x * 2000

func shoot():
	if Input.is_action_just_pressed("shoot") and canShoot == true:
		var bullet = BULLET_PATH.instance()
		print(get_tree().root)
		get_tree().root.add_child(bullet)
		bullet.global_position = self.global_position
		bullet.direction.x = FACING
		shooting = true
		canShoot = false
		$ReloadLabel.visible = true
		$ReloadLabel.percent_visible = 1
		yield(get_tree().create_timer(0.7), "timeout")
		shooting = false
		canShoot = true
		$ReloadLabel.visible = false
