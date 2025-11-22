extends Node2D

var velocity = Vector2.ZERO

const fragPreload = preload("res://scenes/objects/basic_bullet.tscn")

# call function when instantiated
func _ready():
	spawnFrags(Globals.burstAmount)


var rng = RandomNumberGenerator.new()
func spawnFrags(amount):
	# spawning the bullet fragments
	
	for i in amount:
		var fragGrenade = fragPreload.instantiate()
		# add to the scene root or a projectile container
		get_tree().current_scene.add_child(fragGrenade)
		fragGrenade.global_position = Globals.playerLocation  # spawn at grenade position
		fragGrenade.damage = Globals.burstDamage
	
		# random direction
		var dir = Vector2(rng.randi_range(-400, 200), rng.randi_range(0, -600)).normalized()
		fragGrenade.velocity = dir * 550
	
	queue_free()
