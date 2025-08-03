extends Area2D
class_name PressableButton
@export var animationSprite: AnimatedSprite2D

var active = false

func _ready():
	animationSprite.animation = "default"

func _on_body_entered(body):
	animationSprite.animation = "pressed"
	active = true


func _on_body_exited(body):
	animationSprite.animation = "default"
	active = false
