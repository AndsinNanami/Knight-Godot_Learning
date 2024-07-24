extends CharacterBody2D

#region

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var direction:float = 1
var death:bool = false
@onready var sprite = $AnimatedSprite2D
@onready var temp_2d = $Temperature2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#endregion

func _physics_process(delta):
	_handle_velocity_gravity(delta)
	_handle_velocity_jump()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("to_left", "to_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	_animation_control()
	
	if not death:
		move_and_slide()

# Add the gravity.
func _handle_velocity_gravity(delta:float):
	if not is_on_floor():
		velocity.y += gravity * delta

# Handle jump.
func _handle_velocity_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func _animation_control():
	#动画面向的左右
	#大于0向右，小于0向左
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
	
	#死亡动画
	if death:
		velocity = Vector2(0,0)
		sprite.animation = &"dead"
	
	#运动动画
	if not death:
		if direction == 0 and temp_2d._current_temperature < 2700:
			sprite.play("cold")
		elif direction == 0:
			sprite.play("idle")
		else:
			sprite.play("run")

func dead():
	death = true
	$CollisionShape2D.set_deferred("disabled",true)
	temp_2d.set_deferred("disabled",true)
