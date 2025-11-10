extends Node2D

func _process(_delta):
	# show ability names
	$ability1/ability1Name.text = Globals.ability1
	$ability2/ability2Name.text = Globals.ability2
	
	
	
	##### show other info about abilities #####
	
	# ability 1 info
	if Globals.ability1 == "Basic bullet":
		# if the ability is basic bullet
		$ability1/ability1Damage.text = str(Globals.basicBulletDamage) + " DMG"
		$ability1/ability1Cooldown.text = str(round(Globals.basicBulletCooldown)) + " CD"
	elif Globals.ability1 == "Push wall":
		# if the ability is push wall/wide attack
		$ability1/ability1Damage.text = str(Globals.wideAttackDamage) + " DMG"
		$ability1/ability1Cooldown.text = str(round(Globals.wideAttackCooldown)) + " CD"
	
	
	# ability 2 info
	if Globals.ability2 == "Basic bullet":
		# if the ability is basic bullet
		$ability2/ability2Damage.text = str(Globals.basicBulletDamage) + " DMG"
		$ability2/ability2Cooldown.text = str(int(round(Globals.basicBulletCooldown))) + " CD"
	elif Globals.ability2 == "Push wall":
		# if the ability is push wall/wide attack
		$ability2/ability2Damage.text = str(Globals.wideAttackDamage) + " DMG"
		$ability2/ability2Cooldown.text = str(int(round(Globals.wideAttackCooldown))) + " CD"
	
