extends Node2D

var normalSprite = preload("res://icon.svg")
var hurtSprite = preload("res://art/temporary sprites/erm what.jpg")

var health = 4
var damage = 2






# take an amount of damage for the projectiles to call
func takeDamage(amount):
	health -= amount

# take knockback from being hit by bigger attacks
func takeKB(amount):
	position.y -= amount





# enemy will travel towards the player location
func moveToPlayer():
	var speed = 1.2
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
