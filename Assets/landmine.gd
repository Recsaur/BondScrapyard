extends Node2D

var EnemiesInRange = []
var MineDmg = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(EnemiesInRange.size())
	pass


func _on_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy_Normal"):
		ExplodeMine()
	pass # Replace with function body.

func ExplodeMine():
	$GPUParticles2D.emitting = true
	$Sprite2D.hide()
	if EnemiesInRange.size() > 5:
		MineDmg = 25
	elif EnemiesInRange.size() > 3:
		MineDmg = 50
	for Enemy in EnemiesInRange:
		Enemy.Health -= MineDmg
		Enemy.DmgEffect(MineDmg)
	await get_tree().create_timer(0.25).timeout
	queue_free()
	

func _on_explosion_rad_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy_Normal"):  
		EnemiesInRange.append(body)
	pass # Replace with function body.


func _on_explosion_rad_body_exited(body: Node2D) -> void:
	EnemiesInRange.erase(body)
	pass # Replace with function body.
