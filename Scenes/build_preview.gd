extends Node2D

var Bullet_path = preload("res://Scenes/Characters/bullet.tscn")
var Knockback = 0.0


func _ready() -> void:
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	$Pivot.look_at(get_global_mouse_position())
