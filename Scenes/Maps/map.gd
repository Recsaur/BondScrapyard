extends Node2D
var Enemy_N_Path = preload("res://Scenes/Characters/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	pass
	
func EnemySpawn(Type : String):
	if Type == "Normal":
		var Enemy = Enemy_N_Path.instantiate()
		add_child(Enemy)
		
	


func _on_spawn_timer_timeout() -> void:
	EnemySpawn("Normal")
