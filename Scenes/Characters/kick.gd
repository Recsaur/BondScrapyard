extends Area2D
var dmg = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("Apply_Knockback"):
		if body.is_in_group("Enemy"):
			#print(body)
			body.Health -= dmg
			body.DmgEffect(dmg)
			body.Apply_Knockback(GameTracker.player_pos,1750)
			var ogspeed = body.Speed
			body.Speed = 0
			await get_tree().create_timer(0.25).timeout
			if is_instance_valid(body):
				body.Speed = ogspeed
