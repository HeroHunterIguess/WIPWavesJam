extends Node2D

# preload enemy scenes
const BasicEnemyPreload = preload("res://scenes/objects/enemy.tscn")
const BasicBulletPreload = preload("res://scenes/objects/basic_bullet.tscn")

var mousePos

# runs the frame this script/scene is loaded
func _ready(): 
	# spawn some test enemies
	spawnEnemyAtCoords(100,100)
	spawnEnemyAtCoords(500,500)
	spawnEnemyAtCoords(350,200)
	
	

# spawn enemy at inputted coordinates
func spawnEnemyAtCoords(x,y):
	var BasicEnemy = BasicEnemyPreload.instantiate()
	add_child(BasicEnemy)
	BasicEnemy.global_position = Vector2(x,y)

# spawn a bullet and make it go towards the mouse
func spawnBulletWithDirection(mx,my):
	print("spawnikng bullet")
	
	# spawning bullet at player location
	var BasicBullet = BasicBulletPreload.instantiate()
	add_child(BasicBullet)
	BasicBullet.global_position = Vector2(580,580)
	
	var speed = 2
	# calculate distance to player location
	var distancex = mx - BasicBullet.global_position.x
	var distancey = my - BasicBullet.global_position.y
	var distance = sqrt(pow(distancex, 2) + pow(distancey, 2))
	
	if distance > 0:
		# increase x and y to get to location
		BasicBullet.global_position.x += (distancex / distance) * speed
		BasicBullet.global_position.y += (distancey / distance) * speed



# runs every frame
func _process(_time):
	mousePos = get_viewport().get_mouse_position()
	if Input.is_action_just_pressed("ability1"):
		spawnBulletWithDirection(mousePos.x,mousePos.y)
