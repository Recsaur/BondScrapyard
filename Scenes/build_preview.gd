extends Node2D

var Sentry_path = preload("res://Scenes/normal_sentry.tscn")
var Knockback = 0.0


func _ready() -> void:
	look_at(get_global_mouse_position())

func _physics_process(_delta: float) -> void:
	$Pivot.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Shoot"):
		PlaceBuild()
		#print('place once')

func PlaceBuild():
	var Build = Sentry_path.instantiate()
	Build.global_position = $Pivot/Sprite2D.global_position
	get_parent().get_parent().add_child(Build)
	GameTracker.scrap_amt -= 3
	if GameTracker.scrap_amt < 3:
		queue_free()
