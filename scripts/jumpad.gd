extends Area2D

@export var launch_speed: float
@export var cooldownTimer: Timer
@export var cooldown: bool

func _on_body_entered(body):
	if(body.is_in_group("launchable") && !cooldown):
		body.velocity.y = -launch_speed
		cooldown = true
		cooldownTimer.start()


func _on_cooldown_timeout():
	cooldown = false
