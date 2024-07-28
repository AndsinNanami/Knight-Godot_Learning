extends Area2D

var _insert_objs:Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(enter_obj_insert)
	self.body_exited.connect(enter_obj_delete)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not _insert_objs.is_empty():
		for body in _insert_objs:
			body.set_temperature(2500)


#记录进入了的对象

func enter_obj_insert(body:Node2D):
	print("进入变温区")
	if body.has_node("temperature2D"):
		_insert_objs.append(body.get_node("temperature2D"))
		for bd in _insert_objs:
			print(bd)


#删除离开的对象
func enter_obj_delete(body:Node2D):
	print("离开变温区")
	body.get_node("temperature2D").non_set_temperature()
	_insert_objs.erase(body.get_node("temperature2D"))

