extends Area2D


var _insert_bodys:Array[Node2D]
var enviroment_temp:int = 2500

# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(enter_obj_insert)
	self.body_exited.connect(enter_obj_delete)
	self.area_entered.connect(enter_obj_insert)
	self.area_exited.connect(enter_obj_delete)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not _insert_bodys.is_empty():
		for body in _insert_bodys:
			body.set_temperature(self)

#记录进入了的对象
func enter_obj_insert(body:Node2D):
	print("进入变温区")
	if body.has_node("Temperature2D"):
		_insert_bodys.append(body.get_node("Temperature2D"))
		for bd in _insert_bodys:
			print(bd)

#删除离开的对象
func enter_obj_delete(body:Node2D):
	print("离开变温区")
	body.get_node("Temperature2D").non_set_temperature(self)
	_insert_bodys.erase(body.get_node("Temperature2D"))
