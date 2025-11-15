extends Node


# random things
var orbs = 0
var overallScore = 0
var currentWave = 1
var rerollCost = 20



var playerLocation = Vector2(640,688)
var playerHealth = 20
var noWave = false




# vars for push wall attack
var wideAttackBaseCost = 35
var wideAttackCooldown = 230
var wideAttackDamage = 0.375
var wideAttackSpeed = 190
var wideAttackLevel = 1



# vars for basic bullet
var basicBulletCooldown = 18
var basicBulletDamage = 1.7
var basicBulletSpeed = 560
var basicBulletLevel = 1



# vars for frag grenade
var fragGrenadeBaseCost = 25
var fragGrenadeCooldown = 325
var fragGrenadeDamage = 10
var fragGrenadeSpeed = 350
var fragGrenadeAmount = 8
var fragDamage = 1.5
var fragGrenadeLevel = 1



# list of all ability names:
# Push wall
# Basic bullet
# Lazer             (not done)
# Frag grenade      (not done)
# Giant bullet      (not done)


# abilities selected
var ability1 = "Basic bullet" 
var ability2 = "empty slot"







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
