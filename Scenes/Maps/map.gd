extends Node2D
var Enemy_N_Path = preload("res://Scenes/Characters/enemy.tscn")
var Enemy_B_Path = preload("res://Scenes/bat_enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
		add_child(EnemyNorm)
	if Type == "Bat":
		var EnemyBat = Enemy_B_Path.instantiate()
		add_child(EnemyBat)
		
func _on_spawn_timer_timeout() -> void:
	#EnemySpawn("Normal")
	pass
	
func _on_intermission_timer_timeout() -> void:
	for N_Enemy in range(int(GameTracker.NEnemyAmt)):
		EnemySpawn("Normal")
	for B_Enemy in range(int(GameTracker.BEnemyAmt)):
		EnemySpawn("Bat")
	IncreaseEnemyAmt()
	GameTracker.Current_round += 1
	#include an if statement of if rounds are more than liek 3, then allow ranged enemies
	
func IncreaseEnemyAmt():
	GameTracker.NEnemyAmt *= 1.5
	GameTracker.BEnemyAmt *= 1.75
	#Add here the changing amount of enemy when spawning, call this too for like whern last line of intermission ending
	pass
	
