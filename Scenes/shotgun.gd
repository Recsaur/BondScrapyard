extends Node2D

@onready var SG_Particles = $GPUParticles2D
var Bullet_path = preload("res://Scenes/pellet.tscn")
var Burst_num = 3
var Spread_angle = 25.0
var Knockback = 750.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	look_at(get_global_mouse_position())
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Shoot") and GameTracker.Shotgun_ammo > 0:
		$GPUParticles2D.restart()
		$GPUParticles2D.emitting = true
		BurstShot()
	if get_global_mouse_position().x > global_position.x:
		$Marker2D/Sprite2D2.flip_v = false
	else:
		$Marker2D/Sprite2D2.flip_v = true

func BurstShot():
	var spread = deg_to_rad(Spread_angle) / 2.0
	var Target_pos = (get_global_mouse_position() - $Marker2D.global_position).normalized()
	GameTracker.Shotgun_ammo -= 1
	for Buck in range(Burst_num):
		var bullet = Bullet_path.instantiate()
		bullet.position = $Marker2D.global_position
		var Random_dist = randf_range(-spread,spread)
		bullet.rotation = $Marker2D.global_rotation
		bullet.target_position = Target_pos.rotated(Random_dist)
		GameStuff.add_child(bullet)
	get_parent().Apply_Knockback($Marker2D.global_position,Knockback)
	GameTracker.emit_signal("Action",15.0)
