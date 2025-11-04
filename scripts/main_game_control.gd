extends Node2D

# preload enemy scenes
const BasicEnemyPreload = preload("res://scenes/objects/enemy.tscn")


# spawn enemy at inputted coordinates
func spawnEnemyAtCoords(x,y):
	var BasicEnemy = BasicEnemyPreload.instantiate()
	add_child(BasicEnemy)
	BasicEnemy.global_position = Vector2(x,y)

# runs the frame this script/scene is loaded
func _ready(): 
	# spawn some test enemies
	spawnEnemyAtCoords(100,100)
	spawnEnemyAtCoords(500,500)
	spawnEnemyAtCoords(350,200)
