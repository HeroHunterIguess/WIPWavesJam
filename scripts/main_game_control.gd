extends Node2D

# creating variables for alot of objects i need

@onready var score_label = $Score
@onready var timer_label = $Timer

@onready var spawn_timer: Timer = $SpawningTimer
@onready var overall_timer: Timer = $OverallGameTimer
@onready var shoot_timer: Timer = $ShootTimer

# starting timer to spawn objects and overall game timer

func _ready() -> void:
	spawn_timer.start()
	overall_timer.start()

# setting up for rng placement and loading enemy objects

var rng = RandomNumberGenerator.new()
var largeEnemy := preload("res://scenes/objects/enemy.tscn")
var mediumEnemy := preload("res://scenes/objects/medium_enemy.tscn")
var smallEnemy := preload("res://scenes/objects/small_enemy.tscn")

# functions to spawn enemies (they are all almost the same but with diff coordinates)

func spawnLargeEnemy():
	var LEnemy = largeEnemy.instantiate()
	add_child(LEnemy)
	LEnemy.position = Vector2(rng.randf_range(0,1150),rng.randf_range(290,410))

func spawnMediumEnemy():
	var MEnemy = mediumEnemy.instantiate()
	add_child(MEnemy)
	MEnemy.position = Vector2(rng.randf_range(0,1150),rng.randf_range(160,330))

func spawnSmallEnemy():
	var SEnemy = smallEnemy.instantiate()
	add_child(SEnemy)
	SEnemy.position = Vector2(rng.randf_range(0,1150),rng.randf_range(0,140))


# acutally spawning enemies when timer runs out

func _on_spawntimer_timeout() -> void:
	spawnLargeEnemy()
	spawnMediumEnemy()
	spawnSmallEnemy()

# end game when timer is up

func _on_overalltimer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/worlds/game_over.tscn")

# reload thing

func _on_shoot_timeout():
	$ReloadSFX.play()

func _process(_time): 
	
	# checking if the player shot
	if Input.is_action_pressed("mouse_click") && Globals.canShoot == true:
		
		# play sfx and start timers to restart things
		$GunshotSFX.play()
		get_tree().create_timer(0.15).connect("timeout", Callable(self, "_on_shoot_timeout"))
		shoot_timer.start()
		
		Globals.shooting = true
		Globals.canShoot = false
		
	#updating on screen labels
	score_label.text = "Score: " + str(Globals.score)
	timer_label.text = str(int(round(overall_timer.time_left)))

# reset canShoot var

func _on_shoottimer_timeout() -> void:
	Globals.canShoot = true
