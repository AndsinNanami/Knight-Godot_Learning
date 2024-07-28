extends HBoxContainer

const HEART_GUI_CLASS = preload("res://scene/heart_gui.tscn")

func SetMaxHearts(max : int):
	for i in range(max):
		var heart = HEART_GUI_CLASS.instantiate()
		add_child(heart)

func updateHearts(currentHealth: int):
	#把所有子类存起来
	var hearts = get_children()
	for i in range(currentHealth):
		hearts[i].update(true)
	for i in range(currentHealth, hearts.size()):
		hearts[i].update(false)
