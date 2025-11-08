extends Control



func _ready():
	$PanelContainer/VBoxContainer/bbDamage.text = "upgrade basic bullet damage ("+str(Globals.basicBulletDamageCost)+" orbs)"
	$PanelContainer/VBoxContainer/bbSpeed.text = "upgrade basic bullet speed ("+str(Globals.basicBulletSpeedCost)+" orbs)"





func shopInput():
	if Input.is_action_just_pressed("openShop") && get_tree().paused == false:
		get_tree().paused = true
	if Input.is_action_just_pressed("openShop") && get_tree().paused == true:
		get_tree().paused = false




# check for buttons pressed & upgrade things
func _on_resume_pressed() -> void:
	get_tree().paused = false
	self.get_parent().visible = false




# upgrade basic bullet damage on button pressed
func _on_bb_damage_pressed() -> void:
	# upgrading if you have enough orbs
	if Globals.orbs >= Globals.basicBulletDamageCost:
		Globals.orbs -= Globals.basicBulletDamageCost
		Globals.basicBulletDamage += 0.6 # amount it increases by
		Globals.basicBulletDamageCost = round(Globals.basicBulletDamageCost * 1.85)
		$PanelContainer/VBoxContainer/bbDamage.text = "UPGRADED!"
		await get_tree().create_timer(0.65).timeout
		$PanelContainer/VBoxContainer/bbDamage.text = "upgrade basic bullet damage ("+str(Globals.basicBulletDamageCost)+" orbs)"
	# youre too broke to upgrade message
	else:
		$PanelContainer/VBoxContainer/bbDamage.text = "NOT ENOUGH ORBS"
		await get_tree().create_timer(0.65).timeout
		$PanelContainer/VBoxContainer/bbDamage.text = "upgrade basic bullet damage ("+str(Globals.basicBulletDamageCost)+" orbs)"


# upgrade basic bullet speed on button pressed
func _on_bb_speed_pressed() -> void:
	# upgrading if you have enough orbs
	if Globals.orbs >= Globals.basicBulletSpeedCost:
		Globals.orbs -= Globals.basicBulletSpeedCost
		Globals.basicBulletSpeed += 92 # how much the speed increases upon upgrade
		Globals.basicBulletSpeedCost = round(Globals.basicBulletSpeedCost * 1.85)
		$PanelContainer/VBoxContainer/bbSpeed.text = "UPGRADED!"
		await get_tree().create_timer(0.65).timeout
		$PanelContainer/VBoxContainer/bbSpeed.text = "upgrade basic bullet speed ("+str(Globals.basicBulletSpeedCost)+" orbs)"
		# youre too broke to upgrade message
	else:
		$PanelContainer/VBoxContainer/bbSpeed.text = "NOT ENOUGH ORBS"
		await get_tree().create_timer(0.65).timeout
		$PanelContainer/VBoxContainer/bbSpeed.text = "upgrade basic bullet speed ("+str(Globals.basicBulletSpeedCost)+" orbs)"
