extends CollisionShape2D

#region

##基础温度
@export var _default_temperature = 2980
#当前温度
var current_temperature:int
#所在环境的总温度
var _environment_temp:int
#记录最近5个变温处理器提供的环境温度
var _envi_logger:Array[Node2D]
var _envi_logger_index:int = 0
#变温速率
const _speed_by_change_temperature:int = 5
#升温还是降温
var _is_be_heated:bool = false

#endregion

func _ready():
	current_temperature = _default_temperature
	_environment_temp = _default_temperature
	#_envi_logger初始化，加入5个2980开的节点
	for i in 5:
		var ps:PackedScene = load("res://scenes/tempe_handle.tscn")
		var th_handle = ps.instantiate()
		th_handle.enviroment_temp = _default_temperature
		_envi_logger.append(th_handle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_get_enviroment_temp()
	if current_temperature > _environment_temp:
		_is_be_heated = false
		_change_temperature()
	elif current_temperature < _environment_temp:
		_is_be_heated = true
		_change_temperature()

func _change_temperature():
	if _is_be_heated:
		current_temperature += _speed_by_change_temperature
		prints("现在温度：",current_temperature)
	else:
		current_temperature -= _speed_by_change_temperature
		prints("现在温度：",current_temperature)

func _get_enviroment_temp():
	var sum:int = 0
	for t in _envi_logger:
		sum += t.enviroment_temp
	_environment_temp = (sum / 5) as int
	if _environment_temp < 0:
		_environment_temp = 0


#region
func set_temperature(temp_handle:Node2D):
	_envi_logger[_envi_logger_index] = temp_handle
	if _envi_logger_index < 4:
		_envi_logger_index += 1
	else:
		_envi_logger_index = 0

func non_set_temperature(temp_handle:Node2D):
	var index = _envi_logger.find(temp_handle)
	if index:
		var nod = load("res://scenes/tempe_handle.tscn").instantiate()
		nod.enviroment_temp = _default_temperature
		_envi_logger[index] = nod
#endregion
