extends CanvasLayer
@onready var PistolAmmo = $PistolAmmo
@onready var ShotgunAmmo = $ShotgunAmmo
@onready var CurrentWeapon = $Currentweapon
@onready var PlayerHealth = $PlayerHealth
@onready var Scraps = $Scraps
@onready var Rounds = $Rounds
@onready var EnemiesLeft = $EnemiesLeft
@onready var Intermission = $Intermission
var IntSkipActive = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	PistolAmmo.text = str("Pistol Ammo: ", GameTracker.Pistol_ammo)
	ShotgunAmmo.text = str("Shotgun Ammo: ", GameTracker.Shotgun_ammo)
	CurrentWeapon.text = str("Current Weapon: ", get_parent().Current_weapon)
	PlayerHealth.text = str("Health: ", GameTracker.player_health)
	Scraps.text = str("Scraps: ", GameTracker.scrap_amt)
	Rounds.text = str("Round: ", GameTracker.Current_round)
	EnemiesLeft.text = str("Enemies Left: ", GameTracker.Enemy_count)
	#print("EY HEre")
	#print(get_parent().get_parent().get_node("IntermissionTimer").time_left)
	if get_parent().get_parent().get_node("IntermissionTimer").is_stopped():
		$Intermission.hide()
	else: 
		Intermission.text = str("Intermission Time: ", "%0.1f" % get_parent().get_parent().get_node("IntermissionTimer").time_left)
		$Intermission.show()
		
	if get_parent().get_parent().get_node("IntermissionTimer").time_left < 5:
		$SkipInt.hide()
		IntSkipActive = false
	else:
		$SkipInt.show()
		IntSkipActive = true
		
	if GameTracker.Last_equipped == 0:
		$WCAR.show()
	else:
		$WCAR.hide()
	
	if Input.is_action_just_pressed("Skip") and IntSkipActive:
		SkipInt()
		


func _on_skip_int_pressed() -> void:
	SkipInt()
	pass # Replace with function body.


func SkipInt():
	get_parent().get_parent().get_node("IntermissionTimer").paused = true
	get_parent().get_parent().get_node("IntermissionTimer").wait_time = 3
	get_parent().get_parent().get_node("IntermissionTimer").paused = false
	get_parent().get_parent().get_node("IntermissionTimer").start()
