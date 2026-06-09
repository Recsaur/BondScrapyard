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
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	In_range = true 
	pass


func _on_collection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameTracker.scrap_amt += 1
		queue_free()
	pass # Replace with function body.
