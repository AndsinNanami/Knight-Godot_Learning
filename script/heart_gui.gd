extends Panel

@onready var sprite_2d = $Sprite2D

func updateh(whole: bool):
	if whole:
		sprite_2d.visible = true
	else :
		sprite_2d.visible = false 
