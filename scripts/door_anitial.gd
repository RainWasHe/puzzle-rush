extends Area2D

@onready var animationSprite: AnimatedSprite2D = $AnimatedSprite2D
@export var collisionShape: CollisionShape2D
@export var newScene: String
@export var button: PressableButton
@export var overlayScreen: AnimationPlayer

func _process(delta):
	if(button.active):
		animationSprite.animation = "opened"
		collisionShape.set_deferred("disabled", false)
	else:
		animationSprite.animation = "default"
		collisionShape.set_deferred("disabled", true)


func _on_body_entered(body):
	if (!collisionShape.disabled and body.is_in_group("player")):
		overlayScreen.play("blackout")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(newScene)
