extends Area2D

@export var animationSprite: AnimatedSprite2D

func _ready():
	animationSprite.animation = "default"
	set_meta("active", false)

func _on_body_entered(body):
	animationSprite.animation = "pressed"
	set_meta("active", true)


func _on_body_exited(body):
	animationSprite.animation = "default"
	set_meta("active", false)
