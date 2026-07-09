extends Node2D

var Bullet_path = preload("res://Scenes/Characters/bullet.tscn")
var Knockback = 0.0
var Shootable = true
@onready var Ar_point = $Marker2D/Sprite2D2

func _ready() -> void:
	look_at(get_global_mouse_position())
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("Shoot") and GameTracker.Pistol_ammo > 0 and Shootable:
		Shoot()
		$GPUParticles2D.restart()
		$GPUParticles2D.emitting = true
	elif Input.is_action_pressed("Shoot") and GameTracker.Pistol_ammo <= 0 and Shootable:
		var NoAmmo = AudioHandler.get_node("Empty")
		NoAmmo.pitch_scale = randf_range(0.85,1.15)
		NoAmmo.play()
	if get_global_mouse_position().x > global_position.x:
		Ar_point.flip_v = false
	elif get_global_mouse_position().x < global_position.x:
		Ar_point.flip_v = true


func Shoot():
	#var tween = create_tween()
	var bullet = Bullet_path.instantiate()
	GameTracker.Pistol_ammo -= 1
	var ARShoot = AudioHandler.get_node("ARShoot")
	ARShoot.pitch_scale = randf_range(0.85,1.15)
	ARShoot.play()
	#tween.tween_property($Marker2D/Sprite2D2,"rotation",$Marker2D/Sprite2D2.rotation_degrees+25,0.2)
	#tween.tween_property($Marker2D/Sprite2D2,"rotation",$Marker2D/Sprite2D2.rotation_degrees-25,0.2)
	bullet.position = $Marker2D.global_position
	bullet.rotation = $Marker2D.global_rotation
	bullet.target_position = (get_global_mouse_position() - $Marker2D.global_position).normalized()
	GameStuff.add_child(bullet)
	get_parent().Apply_Knockback($Marker2D.global_position,Knockback)
	Shootable = false
	$FireRate.start(GameTracker.FireratePistol)

func _on_fire_rate_timeout() -> void:
	Shootable = true
	pass # Replace with function body.
