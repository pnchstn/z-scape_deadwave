extends CharacterBody2D

@onready var sprite = $Sprite

var speed = 120
var gravity = 350
var jump_speed = -250
var was_in_air = false
var was_kneeling = false

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("move_left"):
		input_vector.x = -1
		sprite.flip_h = true
	elif Input.is_action_pressed("move_right"):
		input_vector.x = 1
		sprite.flip_h = false

	velocity.x = input_vector.x * speed

	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		if was_in_air:
			was_in_air = false
			sprite.frame = 0
			sprite.stop()

		if was_kneeling and not Input.is_action_pressed("move_down"):
			was_kneeling = false
			sprite.frame = 0
			sprite.stop()

		if Input.is_action_just_pressed("move_up"):
			velocity.y = jump_speed
			sprite.play("move_up")
		elif Input.is_action_pressed("move_down"):
			was_kneeling = true
			sprite.play("move_down")
		elif input_vector.x != 0:
			sprite.play("walk")

	move_and_slide()
