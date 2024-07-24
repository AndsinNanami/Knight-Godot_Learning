extends Area2D

@onready var timer = $Timer
signal player_death

func _ready():
	self.body_entered.connect(_on_body_entered)
	$Timer.timeout.connect(_on_timer_timeout)

func _on_body_entered(body):
	print("死了")
	body.dead()
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
