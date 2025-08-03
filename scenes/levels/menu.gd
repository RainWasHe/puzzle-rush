extends Control

@export var overlayScreen: AnimationPlayer

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

func _on_texture_button_pressed() -> void:
	overlayScreen.play("blackout")
