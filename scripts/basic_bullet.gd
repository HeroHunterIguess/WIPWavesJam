extends Node2D

var velocity = Vector2.ZERO
var speed = 500
var damage = 2

# go to position based on velocity
func _process(delta: float):
	if velocity != Vector2.ZERO:
		global_position += velocity * delta
