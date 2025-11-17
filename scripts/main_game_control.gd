extends Node2D


# preload enemy scenes
const basicEnemyPreload = preload("res://scenes/objects/enemy types/enemy.tscn")
const basicBulletPreload = preload("res://scenes/objects/basic_bullet.tscn")
const fastEnemyPreload = preload("res://scenes/objects/enemy types/fast_enemy.tscn")
const tankEnemyPreload = preload("res://scenes/objects/enemy types/tank_enemy.tscn")
const wideAttackPreload = preload("res://scenes/objects/wide_attack.tscn")
const fragGrenadePreload = preload("res://scenes/objects/frag_grenade.tscn")
const burstAttackPreload = preload("res://scenes/objects/bullet_burst.tscn")

var mousePos



# create a wave of different types of enemies based on the wave number
func advancedWaveControl(waveNum):
	# timer between wave start and emphasize what wave is starting
	Globals.noWave = true
	await get_tree().create_timer(1.75).timeout
	Globals.noWave = false
	$ui/waveNum.text = str(Globals.currentWave)
	
	# create a basic wave for the first one
	if waveNum == 1:
		spawnBasicWave(waveNum + 2, 4.2 + 0.17 * waveNum) # spawn amount of basic enemies w/ scaled hp
	# slightly more advanced waves until wave 5
	elif waveNum > 1 && waveNum < 5:
		spawnBasicWave(waveNum + 2, 4.2 + 0.12 * waveNum) # spawn amount of basic enemies w/ scaled hp
		spawnFastEnemyWave(round(waveNum / 2), 2.5 + 0.15 * waveNum) # spawn fast enemies w/ scaled hp
	# full standardized waves starting at wave 5
	elif waveNum >= 6:
		spawnBasicWave(waveNum + 1, 4.2 + 0.12 * waveNum) # spawn amount of basic enemies w/ scaled hp
		spawnFastEnemyWave(round(waveNum / 2), 2.5 + 0.1 * waveNum) # spawn fast enemies w/ scaled hp
		spawnTankEnemyWave(round((waveNum / 4))+ 0.5, 18 + 0.15 * waveNum) # spawn tank enemies w/ amount of scaled hp
	




# spawn a wave with a certain amount of basic enemies at random positions (off-screen)
var rng = RandomNumberGenerator.new()
func spawnBasicWave(amountOfEnemies,hp):
	for i in amountOfEnemies:
		var basicEnemy = basicEnemyPreload.instantiate()
		add_child(basicEnemy)
		basicEnemy.health = hp
		basicEnemy.global_position = Vector2(rng.randi_range(-50,1200),rng.randi_range(-70,-1000))

# spawn a wave of a certain amount of faster enemies
func spawnFastEnemyWave(amountOfEnemies,hp):
	for i in amountOfEnemies:
		var fastEnemy = fastEnemyPreload.instantiate()
		add_child(fastEnemy)
		fastEnemy.health = hp
		fastEnemy.global_position = Vector2(rng.randi_range(-50,1200),rng.randi_range(-70,-1000))

# spawn a wave of tank enemies
func spawnTankEnemyWave(amountOfEnemies,hp):
	for i in amountOfEnemies: 
		var tankEnemy = tankEnemyPreload.instantiate()
		add_child(tankEnemy)
		tankEnemy.health = hp
		tankEnemy.global_position = Vector2(rng.randi_range(-50,1200),rng.randi_range(-70,-200))






# runs the frame this script/scene is loaded
func _ready(): 
	# initialize first wave
	advancedWaveControl(Globals.currentWave)
	$pauseMenuLayer.visible = false
	
	
	
	# KEEP THIS LAST IN _READY
	await get_tree().create_timer(25.0).timeout
	$ui/openShopLabel.visible = true







# spawn a bullet and make it go towards the mouse
func spawnBullet():
	
	# reset shoot cooldown
	Globals.basicBulletCooldown = 18
	# spawning bullet at player location
	var basicBullet = basicBulletPreload.instantiate()
	add_child(basicBullet)
	basicBullet.global_position = Vector2(640,688)
	
	# get direction and set velocity to go there
	var dir = (get_global_mouse_position() - basicBullet.global_position).normalized()
	basicBullet.velocity = dir * basicBullet.speed


# spawns the wide push attack in mouse dir
func spawnWideAttack():
	
	Globals.wideAttackCooldown = 200
	
	# spawning the wave at player location
	var wideAttack = wideAttackPreload.instantiate()
	add_child(wideAttack)
	wideAttack.global_position = Vector2(640,688)
	
	# get direction and set velocity to go there
	var dir = (get_global_mouse_position() - wideAttack.global_position).normalized()
	wideAttack.velocity = dir * wideAttack.speed
	
	wideAttack.look_at(mousePos)
	wideAttack.rotation_degrees += 90

func spawnFragGrenade():
	
	# reset shoot cooldown
	Globals.fragGrenadeCooldown = 325
	# spawning bullet at player location
	var fragGrenade = fragGrenadePreload.instantiate()
	add_child(fragGrenade)
	fragGrenade.global_position = Vector2(640,688)
	
	# get direction and set velocity to go there
	var dir = (get_global_mouse_position() - fragGrenade.global_position).normalized()
	fragGrenade.velocity = dir * fragGrenade.speed

# spawning burst attack
func spawnBurstAttack():
	#reset cooldown
	Globals.burstCooldown = 300
	
	#set position
	var burstAttack = burstAttackPreload.instantiate()
	add_child(burstAttack)
	burstAttack.global_position = Vector2(640,688)



# runs every frame
func _process(delta):
	
	# attack cooldowns
	Globals.wideAttackCooldown -= 125 * delta
	Globals.basicBulletCooldown -= 125 * delta
	Globals.fragGrenadeCooldown -= 125 * delta
	Globals.burstCooldown -= 125 * delta
	
	if Globals.wideAttackCooldown < 0:
		Globals.wideAttackCooldown = 0
	if Globals.basicBulletCooldown < 0:
		Globals.basicBulletCooldown = 0
	if Globals.fragGrenadeCooldown < 0:
		Globals.fragGrenadeCooldown = 0
	if Globals.burstCooldown < 0:
		Globals.burstCooldown = 0
	
	
	
	
	# display info on screen
	$ui/Orbs.text = "Orbs: " + str(Globals.orbs)
	if Globals.noWave == false:
		$ui/waveNum.text =  str(Globals.currentWave)
	$ui/Health.text = "HP: " + str(Globals.playerHealth)
	
	# get mouse position obv
	mousePos = get_viewport().get_mouse_position()
	$goobert.look_at(mousePos)
	$goobert.rotation_degrees += 90
	
	
	
	
	if Input.is_action_just_pressed("openShop"):
		$ui/openShopLabel.visible = false
		get_tree().paused = true
		$pauseMenuLayer.visible = true
	
	
	
	#keybind for abilities
	
	if Input.is_action_just_pressed("ability3"):
		## checking for abilities in slot 1 and doing that
		if Globals.ability1 == "Basic bullet" && Globals.basicBulletCooldown <= 0:
			spawnBullet()
		if Globals.ability1 == "Push wall" && Globals.wideAttackCooldown <= 0:
			spawnWideAttack()
		if Globals.ability1 == "Frag grenade" && Globals.fragGrenadeCooldown <= 0:
			spawnFragGrenade()
		if Globals.ability1 == "Burst attack" && Globals.burstCooldown <= 0:
			spawnBurstAttack()
		
		
		# checking for abilities in slot 2 and spawning those
		
	if Input.is_action_just_pressed("ability2"):
		if Globals.ability2 == "Basic bullet" && Globals.basicBulletCooldown <= 0:
			spawnBullet()
		if Globals.ability2 == "Push wall" && Globals.wideAttackCooldown <= 0:
			spawnWideAttack()
		if Globals.ability2 == "Frag grenade" && Globals.fragGrenadeCooldown <= 0:
			spawnFragGrenade()
		if Globals.ability2 == "Burst attack" && Globals.burstCooldown <= 0:
			spawnBurstAttack()
	
	
	
	
	
	
	# send to game over screen if player dies
	if Globals.playerHealth <= 0:
		get_tree().change_scene_to_file("res://scenes/worlds/game_over.tscn")
	
	# spawn new wave if current wave ends
	if is_inside_tree():
		if get_tree().get_nodes_in_group("Enemy").size() == 0 && Globals.noWave == false:
			Globals.currentWave += 1
			advancedWaveControl(Globals.currentWave)




# decrease player health if enemy hits player
func _on_player_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		Globals.decreasePlayerHealth(area.get_parent().damage)
		print(Globals.playerHealth)
