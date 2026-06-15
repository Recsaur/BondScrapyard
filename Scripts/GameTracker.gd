extends Node

var player_pos : Vector2
var player_health = 100.0
var scrap_amt = 0
var Pistol_ammo = 1000
var Shotgun_ammo = 50

var Normal_sentry_dmg = 15
signal Action(value : float)

var Last_equipped = 0
var FireratePistol = 0.25
