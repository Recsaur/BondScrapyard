extends Node2D

var Bullet_path = preload("res://Scenes/Characters/bullet.tscn")
var Knockback = 0.0
var Shootable = true

func _ready() -> void:
	look_at(get_global_mouse_position())
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("Shoot") and GameTracker.Paistol_ammo > 0 and Shootable:
		Shoot()
	if get_global_mouse_position().x > global_position.x:
		$Marker2D/Sprite2D2.flip_v = false
	else:
		$Marker2D/Sprite2D2.flip_v = true


func Shoot():
	var bullet = Bullet_path.instantiate()
	GameTracker.Pistol_ammo -= 1
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
