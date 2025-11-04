extends Node


# just some global variable and the reset function to reset the game

var shooting = false
var score = 0
var canShoot = true

func reset():
	canShoot = true
	score = 0
