extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("get a coin.")
	queue_free()
