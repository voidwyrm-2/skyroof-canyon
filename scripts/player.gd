extends CharacterBody2D

@export var MAX_SPEED = 100
@export var ACCELERATION = 40

@onready var axis = Vector2.ZERO

@onready var hasSetIdle = false
@onready var hasSetMoving = false


func _physics_process(_delta):
	#print($AnimatedSprite2D.animation)
	if axis == Vector2.ZERO and not hasSetIdle:
		hasSetIdle = true
		hasSetMoving = false
		$AnimatedSprite2D.play("idle")
	elif axis != Vector2.ZERO and not hasSetMoving:
		hasSetMoving = true
		hasSetIdle = false
		$AnimatedSprite2D.play("move")
	move()

func move():
	axis = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if axis == Vector2.ZERO:
		velocity = Vector2.ZERO
	else:
		apply_movement(axis * ACCELERATION)
	move_and_slide()

func apply_movement(vec):
	velocity = vec
	velocity = velocity.limit_length(MAX_SPEED)
