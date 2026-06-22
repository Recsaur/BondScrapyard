extends CanvasLayer
@onready var PistolAmmo = $PistolAmmo
@onready var ShotgunAmmo = $ShotgunAmmo
@onready var CurrentWeapon = $Currentweapon
@onready var PlayerHealth = $PlayerHealth
@onready var Scraps = $Scraps
@onready var Rounds = $Rounds
@onready var EnemiesLeft = $EnemiesLeft
@onready var Intermission = $Intermission

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	PistolAmmo.text = str("Pistol Ammo: ", GameTracker.Pistol_ammo)
	ShotgunAmmo.text = str("Shotgun Ammo: ", GameTracker.Shotgun_ammo)
	CurrentWeapon.text = str("Current Weapon: ", get_parent().Current_weapon)
	PlayerHealth.text = str("Health: ", GameTracker.player_health)
	Scraps.text = str("Scraps: ", GameTracker.scrap_amt)
	Rounds.text = str("Round: ", GameTracker.Current_round)
	EnemiesLeft.text = str("Enemies Left: ", GameTracker.Enemy_count)
	print("EY HEre")
	print(get_parent().get_parent().get_node("IntermissionTimer").time_left)
	Intermission.text = str("Intermission Time: ", "%0.1f" % get_parent().get_parent().get_node("IntermissionTimer").time_left)
	pass
