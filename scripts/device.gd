extends Area2D



func _on_body_entered(body: Node2D) -> void:
	var player:Player = body
	player.CAN_REWIND = true
	player.TimerBar.timer.start()
	#player.TimerBar.value = player.TimerBar.timer.
	player.TimerBar.visible = true
	queue_free()
