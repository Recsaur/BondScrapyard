extends Node2D

var Move_speed = 7.5
var In_range = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	#qif GameTracker.player_pos
	if In_range:
		position = Vector2(move_toward(position.x,GameTracker.player_pos.x,Move_speed),move_toward(position.y,GameTracker.player_pos.y,Move_speed))

func _on_collect_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if GameTracker.Last_equipped == 0:
			GameTracker.Pistol_ammo += 5
		elif GameTracker.Last_equipped == 1:
			GameTracker.Shotgun_ammo += 1
		queue_free()
	pass # Replace with function body.

func _on_range_body_entered(body: Node2D) -> void:
	In_range = true 
