extends Area2D

func _on_body_entered(body):
	print("get a coin.")
	queue_free()
