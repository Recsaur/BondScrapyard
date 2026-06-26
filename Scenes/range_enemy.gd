extends CharacterBody2D
var Health = 50
var Speed = randf_range(50,95)
var Scrap_path = preload("res://Scenes/scrap.tscn")
var KB = Vector2.ZERO
var KB_Length = 200.0
var EffectDmg_path = preload("res://Scenes/dmg_particles.tscn")

var Bullet_path = preload("res://Scenes/enemy_bullet.tscn")
var Current_target = GameTracker.player_pos
var Knockback = 0.0
var Fire_rate = 2.0
var Can_shoot = true
# Called when the node enters the scene tree for the first time.

func _physics_process(delta: float) -> void:
	var player_pos = GameTracker.player_pos
	var Increments = delta * Speed
	#use for maybe collecting items
	if Health <= 0:
		var Scrap = Scrap_path.instantiate()
		Scrap.position = position
		GameStuff.add_child(Scrap)
		queue_free()
	position += KB * delta
	KB = KB.move_toward(Vector2.ZERO, KB_Length)
	position = Vector2(move_toward(position.x, player_pos.x, Increments),move_toward(position.y, player_pos.y, Increments))
	var enemy_target = closest_enemy()
	if enemy_target:
		$Sprite2D.look_at(enemy_target.global_position)
		if Can_shoot:
			Shoot(enemy_target)
		if enemy_target.global_position.x > global_position.x:
			$Sprite2D.flip_v = false
		else:
			$Sprite2D.flip_v = true

func Apply_Knockback(KB_Source, KB_Strength):
	var tween  = create_tween()
	var KB_dir = KB_Source.direction_to(global_position)
	KB += KB_dir * KB_Strength
	$Sprite2D.modulate = Color(1.358, 0.49, 0.344)
	tween.tween_property($Sprite2D,"modulate",Color(1.0, 1.0, 1.0, 1.0),0.5)

func DmgEffect(DmgTaken):
	#var tween = create_tween()
	var Effect = EffectDmg_path.instantiate()
	#Effect.global_position.x += 101
	Effect.DmgEffectItself(DmgTaken)
	add_child(Effect)
	#Effect.DmgTaken = DmgTaken
	#tween.tween_property($Label,"position",Vector2($Label.position.x,$Label.position.y-25),0.05).set_trans(Tween.TRANS_BOUNCE)


		#look_at(Current_target.global_position)

func closest_enemy():
	var enemies = get_tree().get_nodes_in_group("Player")
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
