extends CharacterBody2D
var target_position
var Bullet_Speed = 1000
var dmg = GameTracker.Normal_sentry_dmg
var KB = 750
var Sentry_from = null

func _physics_process(delta: float) -> void:
	velocity = target_position * Bullet_Speed 
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("Apply_Knockback"):
		if body.is_in_group("Player"):
			#print(body)
			GameTracker.emit_signal("Action",10.0)
			GameTracker.emit_signal("TookDmg")
			body.Apply_Knockback(Sentry_from.position,KB)
			#body.DmgEffect(dmg)
			GameTracker.player_health -= dmg
			queue_free()


func _on_despawn_timeout() -> void:
	queue_free()
	pass # Replace with function body.
