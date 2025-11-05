extends Node2D

var health = 2

# enemy will travel towards the player location
func moveToPlayer():
	var speed = 0.5
	# calculate distance to player location
	var dx = Globals.playerLocation.x - position.x
	var dy = Globals.playerLocation.y - position.y
	var distance = sqrt(pow(dx, 2) + pow(dy, 2))
	
	if distance > 0:
		# increase x and y to get to location
		position.x += (dx / distance) * speed
		position.y += (dy / distance) * speed

func _process(_time):
	moveToPlayer()
