extends Node2D

var health = 18
var damage = 4


# take an amount of damage for the projectiles to call
func takeDamage(amount):
	health -= amount

# take knockback from being hit by bigger attacks
func takeKB(amount):
	position.y -= amount


# enemy will travel towards the player location
func moveToPlayer():
	var speed = 0.65
	var to_player = Globals.playerLocation - position
	var distance = to_player.length()
	
	if distance > 25:
		if distance > 0:
			var direction = to_player.normalized()
			position += direction * speed
	else:
		queue_free()



# each frame move towards player and check if dead
func _process(_delta):
	moveToPlayer()
	if health <= 0:
		Globals.orbs += 1
		Globals.overallScore += 1
		queue_free()
