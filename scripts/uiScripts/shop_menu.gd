extends Control



func _ready():
	# text for all abilities at slot 1
	if Globals.ability1 == "Basic bullet":
		$ability1Upgrade.text = "Purchase Basic Bullet MK." + str(Globals.basicBulletLevel + 1) + "\n (" + str(Globals.basicBulletLevel * 40) +" orbs)"
	if Globals.ability1 == "Push wall":
		$ability1Upgrade.text = "Purchase Push Wall MK." + str(Globals.wideAttackLevel + 1) + "\n (" + str(Globals.wideAttackLevel * 40) +" orbs)"
	
	# text all abilities at slot 2
	if Globals.ability2 == "Basic bullet":
		$ability2Upgrade.text = "Purchase Basic Bullet MK." + str(Globals.basicBulletLevel + 1) + "\n (" + str(Globals.basicBulletLevel * 40) +" orbs)"
	if Globals.ability2 == "Push wall":
		$ability2Upgrade.text = "Purchase Push Wall MK." + str(Globals.wideAttackLevel + 1) + "\n (" + str(Globals.wideAttackLevel * 40) +" orbs)"
	






func _process(_time):
	if Input.is_action_pressed("openShop") && self.get_parent().visible == false:
		get_tree().paused = false
		self.get_parent().visible = false



# check if you open shop and like youre paused or smth yk
func shopInput():
	if Input.is_action_just_pressed("openShop") && get_tree().paused == false:
		get_tree().paused = true
	if Input.is_action_just_pressed("openShop") && get_tree().paused == true:
		get_tree().paused = false






# resume game if you press resume ofc
func _on_resume_pressed() -> void:
	get_tree().paused = false
	self.get_parent().visible = false




# funcs to do the upgrading
func upgradeBasicBullet():
	Globals.basicBulletCooldown -= 5
	Globals.basicBulletDamage += 1
	Globals.basicBulletSpeed += 90
	Globals.basicBulletLevel += 1

func upgradePushWall():
	Globals.wideAttackCooldown -= 15
	Globals.wideAttackDamage += 0.25
	Globals.wideAttackSpeed += 50
	Globals.wideAttackLevel += 1





# upgrade to new version of abilities
func _on_ability_1_upgrade_pressed() -> void:
	# upgrade whatever ability is currently in that slot
	
	# upgrades for basic bullet
	if Globals.ability1 == "Basic bullet": 
		if Globals.orbs >= Globals.basicBulletLevel * 40:
			upgradeBasicBullet()
		else:
			$ability1Upgrade.text = "NOT ENOUGH ORBS"
			await get_tree().create_timer(0.75).timeout
			$ability1Upgrade.text = "Purchase Basic Bullet MK." + str(Globals.basicBulletLevel + 1) + "\n (" + str(Globals.basicBulletLevel * 40) +" orbs)"
	
	# upgrades for push wall
	if Globals.ability1 == "Push wall":
		if Globals.orbs >= Globals.wideAttackLevel * 50:
			upgradePushWall()
		else:
			$ability1Upgrade.text = "NOT ENOUGH ORBS"
			await get_tree().create_timer(0.75).timeout
			$ability1Upgrade.text = "Purchase Push Wall MK." + str(Globals.wideAttackLevel + 1) + "\n (" + str(Globals.wideAttackLevel * 40) +" orbs)"





func _on_ability_2_upgrade_pressed() -> void:
	# upgrade whatever ability is currently in that slot
	
	# upgrades for basic bullet
	if Globals.ability2 == "Basic bullet": 
		if Globals.orbs >= Globals.basicBulletLevel * 40:
			upgradeBasicBullet()
		else:
			$ability2Upgrade.text = "NOT ENOUGH ORBS"
			await get_tree().create_timer(0.75).timeout
			$ability2Upgrade.text = "Purchase Basic Bullet MK." + str(Globals.basicBulletLevel + 1) + "\n (" + str(Globals.basicBulletLevel * 40) +" orbs)"
	
	# upgrades for push wall
	if Globals.ability2 == "Push wall":
		if Globals.orbs >= Globals.wideAttackLevel * 50:
			upgradePushWall()
		else:
			$ability2Upgrade.text = "NOT ENOUGH ORBS"
			await get_tree().create_timer(0.75).timeout
			$ability2Upgrade.text = "Purchase Push Wall MK." + str(Globals.wideAttackLevel + 1) + "\n (" + str(Globals.wideAttackLevel * 40) +" orbs)"





func _on_buy_new_ability_pressed() -> void:
	pass # Replace with function body.
