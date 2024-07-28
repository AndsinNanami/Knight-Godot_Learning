extends RayCast2D
@onready var ray_castd = $"."
@onready var tile_map = $TileMap




	
func whats_below() -> Vector2i:
	if is_colliding():
		var collision_point = get_collision_point()
		var collision_point_int = collision_point.floor()  # 使用floor函数获取最接近的较小整数
		return collision_point_int
	else :
		return Vector2i(0, 0)
		

