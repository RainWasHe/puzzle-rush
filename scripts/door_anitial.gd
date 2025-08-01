extends Area2D

@onready var animationSprite: AnimatedSprite2D = $AnimatedSprite2D
@export var collisionShape: CollisionShape2D
@export var newScene: String
@export var buttonArea2d: Area2D

func _process(delta):
	if(buttonArea2d.get_meta("active")):
		animationSprite.animation = "opened"
		collisionShape.call_deferred("disabled", false)
	else:
		animationSprite.animation = "default"
		collisionShape.call_deferred("disabled", true)


func _on_body_entered(body):
	print("entered")
	if (!collisionShape.disabled and body.is_in_group("player")):
		get_tree().change_scene_to_file(newScene)
