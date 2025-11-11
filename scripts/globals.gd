extends Node



var orbs = 0
var overallScore = 0
var currentWave = 1




var playerLocation = Vector2(640,688)
var playerHealth = 20
var noWave = false




# vars for push wall attack
var wideAttackCooldown = 230
var wideAttackDamage = 0.375
var wideAttackSpeed = 190
var wideAttackLevel = 1



# vars for basic bullet
var basicBulletCooldown = 18
var basicBulletDamage = 1.375
var basicBulletSpeed = 560
var basicBulletLevel = 1



# list of all ability names:
# Push wall
# Basic bullet
# Lazer             (not done)
# Frag grenade      (not done)
# Giant bullet      (not done)


# abilities selected
var ability1 = "Basic bullet" 
var ability2 = "Push wall"







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
