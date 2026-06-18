extends Node2D

var Mine_path = preload("res://Assets/landmine.tscn")
var Knockback = 0.0


func _ready() -> void:
	look_at(get_global_mouse_position())

func _physics_process(_delta: float) -> void:
	$Pivot.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Shoot"):
		PlaceBuild()
		print('place once')

func PlaceBuild():
	var Mine = Mine_path.instantiate()
	Mine.global_position = $Pivot/Sprite2D.global_position
	get_parent().get_parent().add_child(Mine)
	GameTracker.scrap_amt -= 3
	if GameTracker.scrap_amt < 3:
		queue_free()
