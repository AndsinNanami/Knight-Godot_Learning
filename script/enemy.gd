extends Node2D

const speed = 60
@export var direction:int = 1
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var sprite = $AnimatedSprite2D
@onready var ray_castd = $RayCastd

func _process(delta):
	if ray_cast_right.is_colliding():
		direction=-1
		sprite.flip_h=true
	if ray_cast_left.is_colliding():
		direction=1
		sprite.flip_h=false
	if $temperature2D._temperature < 2700:
		sprite.play("cold")
	else :
		sprite.play("idle")
	position.x += direction * speed * delta

