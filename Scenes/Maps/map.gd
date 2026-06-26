extends Node2D
var Enemy_N_Path = preload("res://Scenes/Characters/enemy.tscn")
var Enemy_B_Path = preload("res://Scenes/bat_enemy.tscn")
var Enemy_R_Path = preload("res://Scenes/range_enemy.tscn")
@onready var SpawnPoints = [$SpawnPoint, $SpawnPoint2, $SpawnPoint3, $SpawnPoint4, $SpawnPoint5, $SpawnPoint6, $SpawnPoint7, $SpawnPoint8, $SpawnPoint9, $SpawnPoint10]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameTracker.connect("TookDmg", TookDmg)
	
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var enemies_count = get_tree().get_nodes_in_group("Enemy").size()
	if enemies_count <= 0:
		GameTracker.No_enemies = true
	else:
		GameTracker.No_enemies = false
	if GameTracker.No_enemies:
		if $IntermissionTimer.is_stopped():
			#print("ITS PLAYING OKAY??")
			$IntermissionTimer.start(15)
	GameTracker.Enemy_count = enemies_count
	
func EnemySpawn(Type : String):
	if Type == "Normal":
		var EnemyNorm = Enemy_N_Path.instantiate()
		EnemyNorm.position = SpawnPoints.pick_random().position #lowk not sure if its inclusive or not, might check but idk im lazy
		add_child(EnemyNorm)
	if Type == "Bat":
		var EnemyBat = Enemy_B_Path.instantiate()
		EnemyBat.position = SpawnPoints.pick_random().position
		add_child(EnemyBat)
	if Type == "Range":
		var EnemyRange = Enemy_R_Path.instantiate()
		EnemyRange.position = SpawnPoints.pick_random().position
		add_child(EnemyRange)

func _on_spawn_timer_timeout() -> void:
	#EnemySpawn("Normal")
	pass
	
func _on_intermission_timer_timeout() -> void:
	for N_Enemy in range(int(GameTracker.NEnemyAmt)):
		EnemySpawn("Normal")
	for B_Enemy in range(int(GameTracker.BEnemyAmt)):
		EnemySpawn("Bat")
	for R_Enemy in range(int(GameTracker.REnemyAmt)):
		EnemySpawn("Range")
	IncreaseEnemyAmt()
	GameTracker.Current_round += 1
	#include an if statement of if rounds are more than liek 3, then allow ranged enemies
	
func IncreaseEnemyAmt():
	if randi_range(0,3) == 1:
		GameTracker.NEnemyAmt *= 1.5
	if randi_range(0,1) == 1 and GameTracker.Current_round > 3:
		GameTracker.BEnemyAmt *= 1.5
	if randi_range(0,1) == 1 and GameTracker.Current_round > 3:
		GameTracker.BEnemyAmt *= 1.5
	#Add here the changing amount of enemy when spawning, call this too for like whern last line of intermission ending
	pass
	
func TookDmg():
	var screen = $Player
	var tween = create_tween()
	screen.modulate = Color(0.875, 0.349, 0.431, 1.0)
	tween.tween_property(screen,"modulate",Color(1.0, 1.0, 1.0),0.125)
