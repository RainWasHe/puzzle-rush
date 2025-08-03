extends Node2D

@export var overlayScreen: AnimationPlayer

func _ready() -> void:
	overlayScreen.play("whiteout")
