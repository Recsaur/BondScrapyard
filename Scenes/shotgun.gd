extends Node2D

var Bullet_path = preload("res://Scenes/pellet.tscn")
var Burst_num = 3
var Spread_angle = 25.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Shoot"):
		BurstShot()

func BurstShot():
	var spread = deg_to_rad(Spread_angle) / 2.0
	var Target_pos = (get_global_mouse_position() - $Marker2D.global_position).normalized()
	for Buck in range(Burst_num):
		var bullet = Bullet_path.instantiate()
		bullet.position = $Marker2D.global_position
		var Random_dist = randf_range(-spread,spread)
		bullet.rotation = $Marker2D.global_rotation
		bullet.target_position = Target_pos.rotated(Random_dist)
		GameStuff.add_child(bullet)
