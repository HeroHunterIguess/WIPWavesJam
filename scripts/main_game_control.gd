extends Node2D


# preload enemy scenes
const basicEnemyPreload = preload("res://scenes/objects/enemy types/enemy.tscn")
const basicBulletPreload = preload("res://scenes/objects/basic_bullet.tscn")
const fastEnemyPreload = preload("res://scenes/objects/enemy types/fast_enemy.tscn")
const tankEnemyPreload = preload("res://scenes/objects/enemy types/tank_enemy.tscn")

var mousePos
var isPaused = false






# create a wave of different types of enemies based on the wave number
func advancedWaveControl(waveNum):
	# timer between wave start and emphasize what wave is starting
	$waveNum.text = "WAVE [ " + str(Globals.currentWave) + " ] STARTING"
	Globals.noWave = true
	await get_tree().create_timer(1.75).timeout
	Globals.noWave = false
	$waveNum.text = "Wave: " + str(Globals.currentWave)
	
	# create a basic wave for the first one
	if waveNum == 1:
		spawnBasicWave(waveNum + 2)
	# slightly more advanced waves until wave 5
	if waveNum > 1 && waveNum < 5:
		spawnBasicWave(waveNum + 2)
		spawnFastEnemyWave(round(waveNum / 2))
	# full standardized waves starting at wave 5
	if waveNum >= 5:
		spawnBasicWave(waveNum + 1)
		spawnFastEnemyWave(round(waveNum / 2))
		spawnTankEnemyWave(round((waveNum / 4))+ 0.5)
	




# spawn a wave with a certain amount of basic enemies at random positions (off-screen)
var rng = RandomNumberGenerator.new()
func spawnBasicWave(amountOfEnemies):
	for i in amountOfEnemies:
		spawnBasicEnemyAtCoords(rng.randi_range(-50,1200),rng.randi_range(-40,-800))

# spawn a wave of a certain amount of faster enemies
func spawnFastEnemyWave(amountOfEnemies):
	for i in amountOfEnemies:
		spawnFastEnemyAtCoords(rng.randi_range(-50,1200),rng.randi_range(-70,-1000))

# spawn a wave of tank enemies
func spawnTankEnemyWave(amountOfEnemies):
	for i in amountOfEnemies:
		spawnTankEnemyAtCoords(rng.randi_range(-50,1200),rng.randi_range(-70,-200))





# runs the frame this script/scene is loaded
func _ready(): 
	# initialize first wave
	advancedWaveControl(Globals.currentWave)




# spawn enemy at inputted coordinates
func spawnBasicEnemyAtCoords(x,y):
	var basicEnemy = basicEnemyPreload.instantiate()
	add_child(basicEnemy)
	basicEnemy.global_position = Vector2(x,y)

# spawn faster variant enemy at coords x y
func spawnFastEnemyAtCoords(x,y):
	var fastEnemy = fastEnemyPreload.instantiate()
	add_child(fastEnemy)
	fastEnemy.global_position = Vector2(x,y)

# spawn a tank enemy at coords x y
func spawnTankEnemyAtCoords(x,y):
	var tankEnemy = tankEnemyPreload.instantiate()
	add_child(tankEnemy)
	tankEnemy.global_position = Vector2(x,y)





# spawn a bullet and make it go towards the mouse
func spawnBullet():
	
	# spawning bullet at player location
	var basicBullet = basicBulletPreload.instantiate()
	add_child(basicBullet)
	basicBullet.global_position = Vector2(576,616)
	
	# get direction and set velocity to go there
	var dir = (get_global_mouse_position() - basicBullet.global_position).normalized()
	basicBullet.velocity = dir * basicBullet.speed





# runs every frame
func _process(_time):
	
	
	
	# display info on screen
	$Orbs.text = "Orbs: " + str(Globals.orbs)
	if Globals.noWave == false:
		$waveNum.text = "Wave: " + str(Globals.currentWave)
	$Health.text = "HP: " + str(Globals.playerHealth)
	
	# get mouse position obv
	mousePos = get_viewport().get_mouse_position()
	$goobert.look_at(mousePos)
	$goobert.rotation_degrees += 90
	
	
	
	
	#keybind for abilities
	if Input.is_action_just_pressed("ability3"):
		spawnBullet()
	
	
	
	
	# send to game over screen if player dies
	if Globals.playerHealth <= 0:
		get_tree().change_scene_to_file("res://scenes/worlds/game_over.tscn")
	
	# spawn new wave if current wave ends
	if get_tree().get_nodes_in_group("Enemy").size() == 0 && Globals.noWave == false:
		Globals.currentWave += 1
		advancedWaveControl(Globals.currentWave)




# decrease player health if enemy hits player
func _on_player_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		Globals.decreasePlayerHealth(2)
		print(Globals.playerHealth)
