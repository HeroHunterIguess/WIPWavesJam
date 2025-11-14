extends Node2D

var velocity = Vector2.ZERO
var speed = Globals.fragGrenadeSpeed
var damage = Globals.fragGrenadeDamage

const fragPreload = preload("res://scenes/objects/basic_bullet.tscn")



var rng = RandomNumberGenerator.new()
func spawnFrags(amount):
	# spawning smaller frags
	
	for i in amount:
		var fragGrenade = fragPreload.instantiate()
		# add to the scene root or a projectile container
		get_tree().current_scene.add_child(fragGrenade)
		fragGrenade.global_position = self.global_position  # spawn at grenade position
		fragGrenade.damage = Globals.fragDamage
	
		# random direction
		var dir = Vector2(rng.randi_range(-1000, 1000), rng.randi_range(-1000, 1000)).normalized()
		fragGrenade.velocity = dir * 550
	
	queue_free()



# go to position based on velocity
func _process(delta: float):
	if velocity != Vector2.ZERO:
		global_position += velocity * delta
	
	if self.position.x > 2000 or self.position.x < -1000:
		queue_free()
	if self.position.y > 2000 or self.position.y < -1000:
		queue_free()



func _on_frag_grenade_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		area.get_parent().takeDamage(damage)
		area.get_parent().takeKB(5)
		
		spawnFrags(Globals.fragGrenadeAmount)
		
