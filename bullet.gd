extends CharacterBody2D
var target_position
var Bullet_Speed = 1000
var dmg = 15
var KB = 750
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	velocity = target_position * Bullet_Speed 
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("Apply_Knockback"):
		if body.is_in_group("Enemy"):
			#print(body)
			body.Apply_Knockback(GameTracker.player_pos,KB)
			body.DmgEffect(dmg)
			body.Health -= dmg
			queue_free()


func _on_despawn_timeout() -> void:
	queue_free()
	pass # Replace with function body.
