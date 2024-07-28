extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@export var direction:int = 1
@export var death:bool = false
@onready var sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var games = $".."
@onready var h_box_container = $"../CanvasLayer/HBoxContainer"




var maxHeart: int = 3
var currentHeart :int = maxHeart
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


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
	
	move_and_slide()

# Add the gravity.
func _handle_velocity_gravity(delta:float):
	if not is_on_floor():
		velocity.y += gravity * delta

# Handle jump.
func _handle_velocity_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		SoundManager.play_sfx("Jump")
	if Input.is_action_pressed("fire"):
		sprite.play("fire")
		SoundManager.play_sfx("Firing")

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
		$CollisionShape2D.set_deferred("disabled",true)
		$temperature2D.set_deferred("disabled",true)

func dead():
	death = true
	collision.set_deferred("disabled",true)
	sprite.animation = &"dead"


#角色受伤
func player_hurt(area):
	currentHeart -= 1
	if currentHeart:
		h_box_container.updateHearts(currentHeart)
		
	else :
		h_box_container.updateHearts(currentHeart)
		death = true
