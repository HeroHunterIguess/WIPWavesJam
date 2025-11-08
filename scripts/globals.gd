extends Node



var orbs = 0
var overallScore = 0
var currentWave = 1


var playerLocation = Vector2(640,688)
var playerHealth = 20
var noWave = false


var wideAttackCooldown = 200
var basicBulletCooldown = 18

# vars for basic bullet upgrades
var basicBulletDamage = 1.25
var basicBulletSpeed = 500
var basicBulletSpeedCost = 20
var basicBulletDamageCost = 20

#


# decrease player health by certain amount
func decreasePlayerHealth(amount):
	playerHealth -= amount


func hitByBasicBullet(EnemyHP):
	EnemyHP -= 1
	return EnemyHP

# resetting all essential variables back to defaults 
func reset():
	orbs = 0
	playerHealth = 20
	currentWave = 1
	noWave = false
