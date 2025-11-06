extends Node



var orbs = 0
var overallScore = 0
var currentWave = 1
var playerLocation = Vector2(580,580)
var playerHealth = 20
var noWave = false



func decreasePlayerHealth(amount):
	playerHealth -= amount

func hitByBasicBullet(EnemyHP):
	EnemyHP -= 1
	return EnemyHP

func reset():
	orbs = 0
	playerHealth = 20
