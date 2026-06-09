extends Node2D

var Bullet_path = preload("res://Scenes/Characters/bullet.tscn")
var Knockback = 0.0


func _ready() -> void:
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Shoot") and GameTracker.Pistol_ammo > 0:
		Shoot()

func Shoot():
	var bullet = Bullet_path.instantiate()
	GameTracker.Pistol_ammo -= 1
	bullet.position = $Marker2D.global_position
	bullet.rotation = $Marker2D.global_rotation
	bullet.target_position = (get_global_mouse_position() - $Marker2D.global_position).normalized()
	GameStuff.add_child(bullet)
	get_parent().Apply_Knockback($Marker2D.global_position,Knockback)
