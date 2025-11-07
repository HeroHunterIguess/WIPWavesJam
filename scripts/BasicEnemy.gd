extends Node2D

var normalSprite = preload("res://icon.svg")
var hurtSprite = preload("res://art/temporary sprites/erm what.jpg")

var health = 4





# take an amount of damage for the projectiles to call
func takeDamage(amount):
	health -= amount
	$Sprite2D.texture = hurtSprite
	$Sprite2D.scale = Vector2(0.06, 0.06) # TEMPORARY WITH THESE TEST IMAGES
	
	await get_tree().create_timer(0.175).timeout
	
	$Sprite2D.texture = normalSprite
	$Sprite2D.scale = Vector2(0.5, 0.5) # TEMPORARY WITH THESE TEST IMAGES

# take knockback from being hit by bigger attacks
func takeKB():
	position.y -= 25


# enemy will travel towards the player location
func moveToPlayer():
	var speed = 0.5
	# calculate distance to player location
	var dx = Globals.playerLocation.x - position.x
	var dy = Globals.playerLocation.y - position.y
	var distance = sqrt(pow(dx, 2) + pow(dy, 2))
	
	if distance > 25:
		# increase x and y to get to location
		position.x += (dx / distance) * speed
		position.y += (dy / distance) * speed
	elif distance <= 25:
		queue_free()





# each frame move towards player and check if dead
func _process(_time):
	moveToPlayer()
	if health <= 0:
		Globals.orbs += 1
		Globals.overallScore += 1
		queue_free()
