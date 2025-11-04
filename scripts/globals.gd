extends Node

# var shoot_label: Label

# func _ready():
	# shoot_label = get_tree().root.get_node("res://scenes/worlds/main_game_scene.tscn/ShootText")

# just some global variable and the reset function to reset the game

var shooting = false
var score = 0
var canShoot = true

func reset():
	canShoot = true
	score = 0

# func _process(_time):
	# if canShoot == true:
		# shoot_label.text = "Shoot!"
	# if canShoot == false:
		# shoot_label.text = ""
