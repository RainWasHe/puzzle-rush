extends Area2D

@export var animationSprite: AnimatedSprite2D
var isActive = false



func _on_body_entered(body):
	animationSprite.animation = "pressed"
	isActive = true


func _on_body_exited(body):
	animationSprite.animation = "default"
	isActive = false
