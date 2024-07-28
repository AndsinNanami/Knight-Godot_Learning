extends Node
@onready var sfx = $SFX
@onready var bgm = $bgm

func play_sfx(name : String) -> void: 
	var player := sfx.get_node(name) as AudioStreamPlayer2D
	if not player:
		return
	else :
		player.play()

func bgm_player(stream: AudioStreamPlayer2D):
	if bgm.stream == stream and bgm.playing:
		return
	bgm.stream = stream
	bgm.play()
