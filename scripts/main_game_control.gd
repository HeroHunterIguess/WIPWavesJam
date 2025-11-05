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
func spawnBullet():
	print("spawnikng bullet")
	
	# spawning bullet at player location
	var BasicBullet = BasicBulletPreload.instantiate()
	add_child(BasicBullet)
	BasicBullet.global_position = Vector2(580,580)
	
	# get direction and set velocity to go there
	var dir = (get_global_mouse_position() - BasicBullet.global_position).normalized()
	BasicBullet.velocity = dir * BasicBullet.speed

# runs every frame
func _process(_time):
	mousePos = get_viewport().get_mouse_position()
	
	#keybind for abilities
	if Input.is_action_just_pressed("ability1"):
		spawnBullet()
