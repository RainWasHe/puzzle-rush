extends Area2D

@export var launch_speed: float
@export var cooldownTimer: Timer
@export var cooldown: bool
@export var AnimatedSprite: AnimatedSprite2D
@export var particle: CPUParticles2D

func _on_body_entered(body):
	if(body.is_in_group("launchable") && !cooldown):
		particle.emitting = true
		AnimatedSprite.animation = "launch"
		body.velocity.y = -launch_speed
		cooldown = true
		cooldownTimer.start()


func _on_cooldown_timeout():
	AnimatedSprite.animation = "default"
	cooldown = false
