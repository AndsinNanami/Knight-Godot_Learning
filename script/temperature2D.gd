extends Node2D

#本对象的温度
@export var _temperature:int = 2980
#所在环境的总温度
@export var _environment_temp:int = 2980
#变温速率
var speed_by_change_temperature:int = 5
#升温还是降温
var is_be_heated:bool = false
#这一帧是否调用过set_temperature
var is_seted_tempe:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if _temperature > _environment_temp:
		is_be_heated = false
		_change_temperature()
	elif _temperature < _environment_temp:
		is_be_heated = true
		_change_temperature()

func _change_temperature():
	if is_be_heated:
		_temperature += speed_by_change_temperature
		prints("现在温度：",_temperature)
	else:
		_temperature -= speed_by_change_temperature
		prints("现在温度：",_temperature)

func set_temperature(target_tempe:int):
	_environment_temp = target_tempe
	if _environment_temp < 0:
		_environment_temp = 0
	is_seted_tempe = true

func non_set_temperature():
	_environment_temp = 2980
