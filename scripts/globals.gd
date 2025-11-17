extends Node


# random things
var orbs = 0
var overallScore = 0
var currentWave = 1
var rerollCost = 10



var playerLocation = Vector2(640,688)
var playerHealth = 30
var noWave = false





# vars for push wall attack
var wideAttackBaseCost = 35
var wideAttackCooldown = 230
var wideAttackDamage = 0.375
var wideAttackSpeed = 190
var wideAttackLevel = 1


# vars for basic bullet
var basicBulletCooldown = 16
var basicBulletDamage = 1.75
var basicBulletSpeed = 585
var basicBulletLevel = 1


# vars for frag grenade
var fragGrenadeBaseCost = 25
var fragGrenadeCooldown = 325
var fragGrenadeDamage = 10
var fragGrenadeSpeed = 350
var fragGrenadeAmount = 8
var fragDamage = 1.5
var fragGrenadeLevel = 1


# vars for bullet burst attack
var burstAmount = 15
var burstDamage = 1.5
var burstCooldown = 300
var burstLevel = 1
var burstBaseCost = 30


# list of all ability names:
# Push wall
# Basic bullet
# Lazer             (not done)
# Burst attack
# Frag grenade      
# Giant bullet      (not done)
# empty slot

# abilities selected
var ability1 = "Basic bullet" 
var ability2 = "Burst attack"







# decrease player health by certain amount
func decreasePlayerHealth(amount):
	playerHealth -= amount


func hitByBasicBullet(EnemyHP):
	EnemyHP -= 1
	return EnemyHP




# resetting all essential variables back to defaults 
func reset():
	orbs = 0
	playerHealth = 30
	currentWave = 1
	noWave = false
