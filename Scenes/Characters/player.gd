extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -400.0
var KB = Vector2.ZERO
var KB_Length = 25.0
var Kick_Duration = 0.1
var Kick_Cooldown = 0.35

@onready var Kick_Collision = $FacingPivot/Kick/CollisionShape2D


func _physics_process(delta: float) -> void:
	GameTracker.player_pos = position
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right", "up", "down")
	position += KB * delta
	KB = KB.move_toward(Vector2.ZERO, KB_Length)
	velocity = direction * SPEED
	move_and_slide()
	
	if Input.is_action_just_pressed("Kick") and $FacingPivot/Kick/Timer.is_stopped():
		Kick_Collision.disabled = false
		await get_tree().create_timer(0.1).timeout
		Kick_Collision.disabled = true
		$FacingPivot/Kick/Timer.start()
	
	
func _process(delta: float) -> void:
	$FacingPivot.look_at(get_global_mouse_position())
	
func Apply_Knockback(KB_Source, KB_Strength):
	var KB_dir = KB_Source.direction_to(global_position)
	KB = KB_dir * KB_Strength

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy_Normal"):
		print("IS IN")
		Apply_Knockback(body.position,750)
		

		
	#if body.has_method("Apply_Knockback"):
		#body.Apply_Knockback(global_position,500)
	#pass # Replace with function body.
