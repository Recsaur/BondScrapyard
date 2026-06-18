extends CharacterBody2D
var Health = 100
var Speed = randf_range(180,205)
var Scrap_path = preload("res://Scenes/scrap.tscn")
var KB = Vector2.ZERO
var KB_Length = 200.0
var EffectDmg_path = preload("res://Scenes/dmg_particles.tscn")
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
