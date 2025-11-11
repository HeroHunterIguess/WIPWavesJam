extends Node2D

var velocity = Vector2.ZERO
var speed = Globals.wideAttackSpeed
var damage = Globals.wideAttackDamage

var enemyHitCount = 0


func _ready():
	await get_tree().create_timer(2.0).timeout
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
		area.get_parent().takeKB(20)
		enemyHitCount += 1
		# check if its hit its enemy limit and reset timer
		if enemyHitCount >= 20:
			queue_free()
