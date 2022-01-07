extends KinematicBody2D

var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
var FLOOR_NORMAL : Vector2 = Vector2.UP

var BULLET_PATH = preload("res://src/Weapons/Bullet/Bullet.tscn")
var GERNADE_PATH = preload("res://src/Weapons/Gernade/Gernade.tscn")

var IS_ON_GROUND

var HP = 5
var MAX_HP
var FACING = 1
var canShoot = true
var shooting = false
var dashing = false

func _ready():
	MAX_HP = HP

func _process(delta):
	if HP > 0:
		$HPLabel.text = str(HP)
	else:
		$HPLabel.text = "RIP"

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
	
	if velocity.x > 0 or velocity.x < 0:
		if dashing == false:
			$AnimatedSprite.play("walk")
	elif dashing == false:
		$AnimatedSprite.animation = "wake"
		$AnimatedSprite.playing = false
		$AnimatedSprite.frame = 4
	
func _unhandled_input(event):
	get_direction()
	jump()
	jump_cancel()
	shoot()
	toss_gernade()
	
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
	if Input.is_action_just_pressed("dash") and dashing == false:
		dashing = true
		velocity.x = direction.x * 2000
		yield(get_tree().create_timer(0.7), "timeout")
		dashing = false

func shoot():
	if Input.is_action_just_pressed("shoot") and canShoot == true:
		var bullet = BULLET_PATH.instance()
		get_tree().root.get_node('Level').add_child(bullet)
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
		
func toss_gernade():
	if Input.is_action_just_pressed("gernade"):
		var gernade = GERNADE_PATH.instance()
		get_tree().root.get_node("Level").add_child(gernade)
		gernade.global_position = self.global_position
		gernade.direction.x = FACING
		
func on_Enemy_hit():
	HP -= 1
