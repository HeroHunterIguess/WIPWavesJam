extends Node2D

@onready var score_label = $ScoreLabel

# tell player their score

func _ready():
	score_label.text = "Score: " + str(Globals.score)


# reset game on end of game

func _on_button_pressed() -> void:
	Globals.reset()
	get_tree().change_scene_to_file("res://scenes/worlds/main_game_scene.tscn")
