extends Area2D

const speed = 60
var direction = 1
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	if ray_cast_right.is_colliding():
		direction=-1
		sprite.flip_h=true
	if ray_cast_left.is_colliding():
		direction=1
		sprite.flip_h=false
	position.x += direction * speed * delta
