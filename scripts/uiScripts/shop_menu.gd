extends Control

func updateUpgradeText():
	# text for all abilities at slot 1
	if Globals.ability1 == "Basic bullet":
		$ability1Upgrade.text = "Purchase Basic Bullet MK." + str(Globals.basicBulletLevel + 1) + "\n (" + str(Globals.basicBulletLevel * 35) +" orbs)"
	if Globals.ability1 == "Push wall":
		$ability1Upgrade.text = "Purchase Push Wall MK." + str(Globals.wideAttackLevel + 1) + "\n (" + str(Globals.wideAttackLevel * 35) +" orbs)"
	if Globals.ability1 == "Frag grenade":
		$ability1Upgrade.text = "Purchase Frag Grenade MK." + str(Globals.fragGrenadeLevel + 1) + "\n (" + str(Globals.fragGrenadeLevel * 35) +" orbs)"
	if Globals.ability1 == "Burst attack":
		$ability1Upgrade.text = "Purchase Burst Attack MK." + str(Globals.burstLevel + 1) + "\n (" + str(Globals.burstLevel * 35) +" orbs)"
	
	
	# text for all abilities at slot 2
	if Globals.ability2 == "Basic bullet":
		$ability2Upgrade.text = "Purchase Basic Bullet MK." + str(Globals.basicBulletLevel + 1) + "\n (" + str(Globals.basicBulletLevel * 35) +" orbs)"
	if Globals.ability2 == "Push wall":
		$ability2Upgrade.text = "Purchase Push Wall MK." + str(Globals.wideAttackLevel + 1) + "\n (" + str(Globals.wideAttackLevel * 35) +" orbs)"
	if Globals.ability2 == "Frag grenade":
		$ability2Upgrade.text = "Purchase Frag Grenade MK." + str(Globals.fragGrenadeLevel + 1) + "\n (" + str(Globals.fragGrenadeLevel * 35) +" orbs)"
	if Globals.ability2 == "Burst attack":
		$ability2Upgrade.text = "Purchase Burst Attack MK." + str(Globals.burstLevel + 1) + "\n (" + str(Globals.burstLevel * 35) +" orbs)"


var rng = RandomNumberGenerator.new()
func setRandomNewAbility():
	# the random new ability for you to purchase
	var rngAbilityNum = rng.randi_range(1,3)
	
	# select it randomly based on a random number and set apropriate variables
	if rngAbilityNum == 1:
		currentNewAbility = "Push wall"
		newAbilityCost = Globals.wideAttackBaseCost
	elif rngAbilityNum == 2:
		currentNewAbility = "Frag grenade"
		newAbilityCost = Globals.fragGrenadeBaseCost
	elif rngAbilityNum == 3:
		currentNewAbility = "Burst attack"
		newAbilityCost = Globals.burstBaseCost
	
	# setup all the text displays
	
	if currentNewAbility == "Push wall":
		$buyNewAbility.text = "Replace an ability slot with " + currentNewAbility + " (" + str(Globals.wideAttackBaseCost) + " orbs)"
	elif currentNewAbility == "Frag grenade":
		$buyNewAbility.text = "Replace an ability slot with " + currentNewAbility + " (" + str(Globals.fragGrenadeBaseCost) + " orbs)"
	
	
	# set text for which ability is in each slot
	$whichAbility/selectAbility1.text = "Replace " + Globals.ability1 + ""
	$whichAbility/selectAbility2.text = "Replace " + Globals.ability2 + ""


var currentNewAbility = ""
var newAbilityCost = 0


func _ready():
	
	updateUpgradeText()
	
	# reroll text
	$rerollNewAbilities.text = "Reroll abilities (" + str(Globals.rerollCost) + " orbs)"
	
	
	
	
	
	# set random ability to buy
	setRandomNewAbility()
	



func _process(_time):
	if Input.is_action_pressed("openShop") && self.get_parent().visible == false:
		get_tree().paused = false
		self.get_parent().visible = false
	
	if purchasing == false:
		$buyNewAbility.visible = true


# check if you open shop and like youre paused or smth yk
func shopInput():
	if Input.is_action_just_pressed("openShop") && get_tree().paused == false:
		get_tree().paused = true
	if Input.is_action_just_pressed("openShop") && get_tree().paused == true:
		get_tree().paused = false






# resume game if you press resume ofc
func _on_resume_pressed() -> void:
	purchasing = false
	get_tree().paused = false
	self.get_parent().visible = false
	$whichAbility/selectAbility1.visible = false
	$whichAbility/selectAbility2.visible = false




# funcs to do the upgrading
func upgradeBasicBullet():
	Globals.orbs -= Globals.basicBulletLevel * 35
	Globals.basicBulletCooldown -= 5
	Globals.basicBulletDamage += 1
	Globals.basicBulletSpeed += 90
	Globals.basicBulletLevel += 1


func upgradePushWall():
	Globals.orbs -= Globals.wideAttackLevel * 35
	Globals.wideAttackCooldown -= 15
	Globals.wideAttackDamage += 0.25
	Globals.wideAttackSpeed += 40
	Globals.wideAttackLevel += 1


func upgradeFragGrenade():
	Globals.orbs -= Globals.fragGrenadeLevel * 35
	Globals.fragGrenadeCooldown -= 10
	Globals.fragGrenadeDamage += 0.25
	Globals.fragGrenadeSpeed += 50
	Globals.fragGrenadeAmount += 1
	Globals.fragGrenadeLevel += 1
	Globals.fragDamage += 0.2

func upgradeBurstAttack():
	Globals.orbs -= Globals.burstLevel * 35
	Globals.burstAmount += 4
	Globals.burstDamage += 0.5
	Globals.burstCooldown -= 40
	Globals.burstLevel += 1


# upgrade to new version of abilities
func _on_ability_1_upgrade_pressed() -> void:
	# upgrade whatever ability is currently in that slot
	
	# upgrades for basic bullet
	if Globals.ability1 == "Basic bullet": 
		if Globals.orbs >= Globals.basicBulletLevel * 35:
			upgradeBasicBullet()
			$ability1Upgrade.text = "PURCHASED"
			await get_tree().create_timer(1.0).timeout
			$ability2Upgrade.text = "Purchase Basic Bullet MK." + str(Globals.basicBulletLevel + 1) + "\n (" + str(Globals.basicBulletLevel * 35) +" orbs)"
		else:
			$ability1Upgrade.text = "NOT ENOUGH ORBS"
			await get_tree().create_timer(0.75).timeout
			$ability1Upgrade.text = "Purchase Basic Bullet MK." + str(Globals.basicBulletLevel + 1) + "\n (" + str(Globals.basicBulletLevel * 35) +" orbs)"
	
	# upgrades for push wall
	if Globals.ability1 == "Push wall":
		if Globals.orbs >= Globals.wideAttackLevel * 35:
			upgradePushWall()
			$ability1Upgrade.text = "PURCHASED"
			await get_tree().create_timer(1.0).timeout
			$ability1Upgrade.text = "Purchase Push Wall MK." + str(Globals.wideAttackLevel + 1) + "\n (" + str(Globals.wideAttackLevel * 35) +" orbs)"
		else:
			$ability1Upgrade.text = "NOT ENOUGH ORBS"
			await get_tree().create_timer(0.75).timeout
			$ability1Upgrade.text = "Purchase Push Wall MK." + str(Globals.wideAttackLevel + 1) + "\n (" + str(Globals.wideAttackLevel * 35) +" orbs)"
	
	if Globals.ability1 == "Frag grenade":
		if Globals.orbs >= Globals.fragGrenadeLevel * 35:
			upgradeFragGrenade()
			$ability1Upgrade.text = "PURCHASED"
			await get_tree().create_timer(1.0).timeout
			$ability1Upgrade.text = "Purchase Frag Grenade MK." + str(Globals.fragGrenadeLevel + 1) + "\n (" + str(Globals.fragGrenadeLevel * 35) +" orbs)"
		else: 
			$ability1Upgrade.text = "NOT ENOUGH ORBS"
			await get_tree().create_timer(0.75).timeout
			$ability1Upgrade.text = "Purchase Frag Grenade MK." + str(Globals.fragGrenadeLevel + 1) + "\n (" + str(Globals.fragGrenadeLevel * 35) +" orbs)"
	
	if Globals.ability1 == "Burst attack":
		if Globals.orbs >= Globals.burstLevel * 35:
			upgradeBurstAttack()
			$ability1Upgrade.text = "PURCHASED"
			await get_tree().create_timer(1.0).timeout
			$ability1Upgrade.text = "Purchase Burst Attack MK." + str(Globals.burstLevel + 1) + "\n (" + str(Globals.burstLevel * 35) +" orbs)"
		else: 
			$ability1Upgrade.text = "NOT ENOUGH ORBS"
			await get_tree().create_timer(0.75).timeout
			$ability1Upgrade.text = "Purchase Burst Attack MK." + str(Globals.burstLevel + 1) + "\n (" + str(Globals.burstLevel * 35) +" orbs)"



func _on_ability_2_upgrade_pressed() -> void:
	# upgrade whatever ability is currently in that slot
	
	# upgrades for basic bullet
	if Globals.ability2 == "Basic bullet": 
		if Globals.orbs >= Globals.basicBulletLevel * 35:
			upgradeBasicBullet()
			$ability2Upgrade.text = "PURCHASED"
			await get_tree().create_timer(1.0).timeout
			$ability2Upgrade.text = "Purchase Basic Bullet MK." + str(Globals.basicBulletLevel + 1) + "\n (" + str(Globals.basicBulletLevel * 35) +" orbs)"
		else:
			$ability2Upgrade.text = "NOT ENOUGH ORBS"
			await get_tree().create_timer(0.75).timeout
			$ability2Upgrade.text = "Purchase Basic Bullet MK." + str(Globals.basicBulletLevel + 1) + "\n (" + str(Globals.basicBulletLevel * 35) +" orbs)"
	
	# upgrades for push wall
	if Globals.ability2 == "Push wall":
		if Globals.orbs >= Globals.wideAttackLevel * 35:
			upgradePushWall()
			$ability2Upgrade.text = "PURCHASED"
			await get_tree().create_timer(1.0).timeout
			$ability1Upgrade.text = "Purchase Push Wall MK." + str(Globals.wideAttackLevel + 1) + "\n (" + str(Globals.wideAttackLevel * 35) +" orbs)"
		else:
			$ability2Upgrade.text = "NOT ENOUGH ORBS"
			await get_tree().create_timer(0.75).timeout
			$ability2Upgrade.text = "Purchase Push Wall MK." + str(Globals.wideAttackLevel + 1) + "\n (" + str(Globals.wideAttackLevel * 35) +" orbs)"
	
	
	if Globals.ability2 == "Frag grenade":
		if Globals.orbs >= Globals.fragGrenadeLevel * 35:
			upgradeFragGrenade()
			$ability2Upgrade.text = "PURCHASED"
			await get_tree().create_timer(1.0).timeout
			$ability2Upgrade.text = "Purchase Frag Grenade MK." + str(Globals.fragGrenadeLevel + 1) + "\n (" + str(Globals.fragGrenadeLevel * 35) +" orbs)"
		else: 
			$ability2Upgrade.text = "NOT ENOUGH ORBS"
			await get_tree().create_timer(0.75).timeout
			$ability2Upgrade.text = "Purchase Frag Grenade MK." + str(Globals.fragGrenadeLevel + 1) + "\n (" + str(Globals.fragGrenadeLevel * 35) +" orbs)"
	
	if Globals.ability2 == "Burst attack":
		if Globals.orbs >= Globals.burstLevel * 35:
			upgradeBurstAttack()
			$ability2Upgrade.text = "PURCHASED"
			await get_tree().create_timer(1.0).timeout
			$ability2Upgrade.text = "Purchase Burst Attack MK." + str(Globals.burstLevel + 1) + "\n (" + str(Globals.burstLevel * 35) +" orbs)"
		else: 
			$ability2Upgrade.text = "NOT ENOUGH ORBS"
			await get_tree().create_timer(0.75).timeout
			$ability2Upgrade.text = "Purchase Burst Attack MK." + str(Globals.burstLevel + 1) + "\n (" + str(Globals.burstLevel * 35) +" orbs)"




var purchasing = false
# function to buy the inputted ability and let you select the slot
func purchaseAbility():
	purchasing = true
	$buyNewAbility.visible = false
	$whichAbility/selectAbility1.visible = true
	$whichAbility/selectAbility2.visible = true

# buy new ability when the ability buy button is pressed
func _on_buy_new_ability_pressed() -> void:
	if newAbilityCost <= Globals.orbs:
		purchaseAbility()
	else:
		# set back to default text if youre broke
		$buyNewAbility.text = "NOT ENOUGH ORBS"
		await get_tree().create_timer(0.75).timeout
		if currentNewAbility == "Push wall":
			$buyNewAbility.text = "Replace an ability slot with " + currentNewAbility + " (" + str(Globals.wideAttackBaseCost) + " orbs)"
		elif currentNewAbility == "Frag grenade":
			$buyNewAbility.text = "Replace an ability slot with " + currentNewAbility + " (" + str(Globals.fragGrenadeBaseCost) + " orbs)"
	




# buttons pressed to acutally make the purchase of the new ability and put it in that slot

func _on_select_ability_1_pressed() -> void:
	Globals.orbs -= newAbilityCost
	Globals.ability1 = currentNewAbility
	$whichAbility/selectAbility1.visible = false
	$whichAbility/selectAbility2.visible = false
	
	setRandomNewAbility()
	updateUpgradeText()
	
	$buyNewAbility.visible = true

func _on_select_ability_2_pressed() -> void:
	Globals.orbs -= newAbilityCost
	Globals.ability2 = currentNewAbility
	$whichAbility/selectAbility1.visible = false
	$whichAbility/selectAbility2.visible = false
	
	setRandomNewAbility()
	updateUpgradeText()
	
	$buyNewAbility.visible = true




# reroll
func _on_reroll_new_abilities_pressed() -> void:
	if Globals.orbs >= Globals.rerollCost:
		Globals.orbs -= Globals.rerollCost
		Globals.rerollCost *= 2
		setRandomNewAbility()
		$rerollNewAbilities.text = "REROLLED"
		await get_tree().create_timer(0.75).timeout
		$rerollNewAbilities.text = "Reroll abilities (" + str(Globals.rerollCost) + " orbs)"
	else: 
		$rerollNewAbilities.text = "NOT ENOUGH ORBS"
		await get_tree().create_timer(0.75).timeout
		$rerollNewAbilities.text = "Reroll abilities (" + str(Globals.rerollCost) + " orbs)"
