extends Node2D

# just the start button so far
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/worlds/main_game_scene.tscn")
