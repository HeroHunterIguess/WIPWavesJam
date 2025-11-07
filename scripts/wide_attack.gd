extends Node2D

var velocity = Vector2.ZERO
var speed = 250
var damage = 0.5

var enemyHitCount = 0


func _ready():
	await get_tree().create_timer(1.5).timeout
	queue_free()


# go to position based on velocity
func _process(delta: float):
	self.scale.x += 1 * delta
	
	if velocity != Vector2.ZERO:
		global_position += velocity * delta
	



func _on_wide_attack_hitbox_area_entered(area: Area2D) -> void:
	# check if it hits enemy then deal kb and damage to enemy
	if area.is_in_group("Enemy"):
		area.get_parent().takeDamage(damage)
		area.get_parent().takeKB()
		enemyHitCount += 1
		# check if its hit its 4 enemy limit and reset timer
		if enemyHitCount >= 4:
			Globals.wideAttackCooldown = 200
			queue_free()
