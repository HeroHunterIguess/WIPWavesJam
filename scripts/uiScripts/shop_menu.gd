extends Control



func _ready():
	$ability1Upgrade.text = ""
	$ability2Upgrade.text = ""



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





# upgrade to new version of abilities
func _on_ability_1_upgrade_pressed() -> void:
	pass # Replace with function body.

func _on_ability_2_upgrade_pressed() -> void:
	pass # Replace with function body.




func _on_buy_new_ability_pressed() -> void:
	pass # Replace with function body.
