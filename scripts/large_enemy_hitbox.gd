extends Area2D

var mouseInside = false

# creating a timer to destroy object after 2 seconds

func _ready():
	get_tree().create_timer(2.0).connect("timeout", Callable(self, "_on_timeout"))

func _on_timeout():
	queue_free()

# check if mouse is inside to destroy object

func _process(_time):
	if mouseInside == true:
		# if mouse inside and clicked then add to score and destroy object
		if Input.is_action_just_pressed("mouse_click") && Globals.canShoot == true:
			$TargetHitSFX.play()
			Globals.score += 1
			queue_free()
			
	# main script detected shooting ig 
	if Globals.shooting == true:
		Globals.score += 1
		queue_free()
		Globals.shooting = false
# checking if mouse is in the object

func _on_mouse_entered() -> void:
	if true:
		mouseInside = true

func _on_mouse_exited() -> void:
	if true:
		mouseInside = false
