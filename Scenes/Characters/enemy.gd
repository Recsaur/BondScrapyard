extends CharacterBody2D
var Health = 100
var Speed = 250

var KB = Vector2.ZERO
var KB_Length = 200.0
# Called when the node enters the scene tree for the first time.

func _physics_process(delta: float) -> void:
	var player_pos = GameTracker.player_pos
	var Increments = delta * Speed
	#use for maybe collecting items
	if Health <= 0:
		queue_free()
	position += KB * delta
	KB = KB.move_toward(Vector2.ZERO, KB_Length)
	position = Vector2(move_toward(position.x, player_pos.x, Increments),move_toward(position.y, player_pos.y, Increments))

func Apply_Knockback(KB_Source, KB_Strength):
	var KB_dir = KB_Source.direction_to(global_position)
	KB += KB_dir * KB_Strength
	
