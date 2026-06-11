extends Node2D

var Bullets_path = preload("res://Scenes/bullet_pickup.tscn")
var Knockback = 0.0


func _ready() -> void:
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	$Pivot.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Shoot"):
		PlaceBuild()
		print('place once')

func PlaceBuild():
	var BulletPick = Bullets_path.instantiate()
	BulletPick.global_position = $Pivot/Sprite2D.global_position
	get_parent().get_parent().add_child(BulletPick)
	GameTracker.scrap_amt -= 1
	if GameTracker.scrap_amt < 1:
		queue_free()
