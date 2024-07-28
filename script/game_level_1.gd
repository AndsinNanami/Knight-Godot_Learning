extends Node2D
@onready var tile_map = $TileMap
@onready var ray_castd = $Player/RayCastd
@onready var sprite = $Player/AnimatedSprite2D
@onready var player = $Player
@onready var h_box_container = $CanvasLayer/HBoxContainer
@export var bgm : AudioStreamPlayer2D









var background :int = 0
var mid :int = 1

func _ready():
	h_box_container.SetMaxHearts(player.maxHeart)
	SoundManager.bgm_player(bgm)

func _process(delta):
	get_tile_map_data()

func get_tile_map_data():
	var collision_point_int = ray_castd.whats_below()
	#世界坐标转换为tile坐标
	var tile_coords = tile_map.local_to_map(collision_point_int)
	#如果下方有物体
	if collision_point_int != Vector2i(0, 0):
		#获取瓷砖数据
		var tile_data: TileData = tile_map.get_cell_tile_data(mid, tile_coords)
		if tile_data:#如果有瓷砖数据
			var tem = tile_data.get_custom_data("tem")
			#监测温度，作出反应
			if !player.death:
				#遇到雪块降温
				if tem == -2:
					sprite.play("cold")
					print("降温")
				#角色动作切换挪到这块来了
				elif tem == 0 and player.direction == 0:
					sprite.play("idle")
					
				elif tem == 0 and player.direction != 0:
					sprite.play("run")
					
