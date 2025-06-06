extends Area2D

@export var speed = 200
var screen_size

var isAttacking = false

var timeTillNextInput = 0.5
var time = 0

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	# Player's movement vector
	var velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("attack"):
		attack()
	if(!isAttacking):
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1

		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			$AnimatedSprite2D.play("Walk")
		else:
			$AnimatedSprite2D.play("Idle")
			
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
		
		if velocity.x != 0:
			$AnimatedSprite2D.animation = "Walk"
			$AnimatedSprite2D.flip_v = false

func attack():
	$AnimatedSprite2D.play("Lunge")
	isAttacking = true
	await $AnimatedSprite2D.animation_finished
	isAttacking = false
	
