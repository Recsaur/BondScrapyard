extends Node2D
var Bullet_path = preload("res://Scenes/sentry_bullet.tscn")
var Current_target = GameTracker.player_pos
var Knockback = 0.0
var Fire_rate = 2.0
var Can_shoot = true


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var enemy_target = closest_enemy()
	if enemy_target:
		look_at(enemy_target.global_position)
		if Can_shoot:
			Shoot(enemy_target)
	#look_at(Current_target.global_position)

func closest_enemy():
	var enemies = get_tree().get_nodes_in_group("Enemy_Normal")
	var nearest_enemy = null
	var shortest_dist = INF
	for enemy in enemies:
		var dist = global_position.distance_to(enemy.global_position)
		if dist < shortest_dist:
			shortest_dist = dist
			nearest_enemy = enemy
	return nearest_enemy
	
func Shoot(enemy):
	var bullet = Bullet_path.instantiate()
	var target_location = enemy.global_position
	Can_shoot = false
	#GameTracker.Pistol_ammo -= 1
	bullet.Sentry_from = self
	bullet.global_position = global_position
	bullet.rotation = enemy.global_rotation
	var direction = (target_location - global_position).normalized()
	bullet.target_position = direction
	bullet.rotation = direction.angle()
	GameStuff.add_child(bullet)
	await get_tree().create_timer(Fire_rate).timeout
	Can_shoot = true
