extends Node

var player_pos : Vector2
var player_health = 100.0
var scrap_amt = 0
var Pistol_ammo = 50
var Shotgun_ammo = 25

var Normal_sentry_dmg = 15
signal Action(value : float)
signal TookDmg()
var Last_equipped = 0
var FireratePistol = 0.25

var Current_round = 1
var No_enemies = false
var Enemy_count = 0

var NEnemyAmt = 2
var BEnemyAmt = 3
var REnemyAmt = 1
