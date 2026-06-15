extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -400.0
const DASH_SPEED = 1500
var KB = Vector2.ZERO
var KB_Length = 25.0
var Kick_Duration = 0.1
var Kick_Cooldown = 0.35
var invuln = false
var Pistol_path = preload("res://Scenes/pistol.tscn")
var Shotgun_path = preload("res://Scenes/Shotgun.tscn")

enum Weapons {
	Pistol,
	Shotgun
}

var Weapon = Weapons.Pistol

var Current_weapon = Weapons.Pistol
var Build_mode = false
@onready var Kick_Collision = $FacingPivot/Kick/CollisionShape2D
@onready var BHUD = $Building_UI

#Enemy damgese
var NormalEnemy_dmg = 15

func _physics_process(delta: float) -> void:
	GameTracker.player_pos = position
	var direction := Input.get_vector("left", "right", "up", "down")
	position += KB * delta
	KB = KB.move_toward(Vector2.ZERO, KB_Length)
	velocity = direction * SPEED
	
	if Input.is_action_just_pressed("Dash"):
		Dash(direction,500)
		
	if Input.is_action_just_pressed("Building"):
		if not BHUD.visible:
			BHUD.show()
			Build_mode = true
			$Building_UI/NS.show()
			$Building_UI/M.show()
			$Building_UI/HS.show()
			if has_node("Pistol"):
				var pistol = get_node("Pistol")
				pistol.queue_free()
			if has_node("Shotgun"):
				var shotgun = get_node("Shotgun")
				shotgun.queue_free()
		else:
			BHUD.hide()
			Build_mode = false
			$Building_UI/NS.hide()
			$Building_UI/M.hide()
			$Building_UI/HS.hide()
			$Building_UI.set_chosen_build(0)
			for Build in get_tree().get_nodes_in_group("Building"):
				Build.queue_free()
			if GameTracker.Last_equipped == 0:
				var pistol = Pistol_path.instantiate()
				add_child(pistol)
			if GameTracker.Last_equipped == 1:
				var shotgun = Shotgun_path.instantiate()
				add_child(shotgun)
		print("OPEHEN")
	move_and_slide()
	
	if Build_mode:
		Buildings()
	
	if Input.is_action_just_pressed("Kick") and $FacingPivot/Kick/Timer.is_stopped():
		Kick_Collision.disabled = false
		await get_tree().create_timer(0.1).timeout
		Kick_Collision.disabled = true
		$FacingPivot/Kick/Timer.start()
	
	#Weapon Switching but liek only left right keybindd
	if Input.is_action_just_pressed("SwitchWeaponLeft") and not Build_mode:
		if Current_weapon == Weapons.Pistol:
			Current_weapon = Weapons.Shotgun
			WeaponSwitching()
		if Current_weapon == Weapons.Shotgun:
			Current_weapon = Weapons.Pistol
			WeaponSwitching()
		
	elif Input.is_action_just_pressed("SwitchWeaponLeft") and Build_mode:
		BHUD.hide()
		Build_mode = false
		$Building_UI/NS.hide()
		$Building_UI/M.hide()
		$Building_UI/HS.hide()
		$Building_UI.set_chosen_build(0)
		for Build in get_tree().get_nodes_in_group("Building"):
			Build.queue_free()
		if GameTracker.Last_equipped == 0:
			var pistol = Pistol_path.instantiate()
			add_child(pistol)
		if GameTracker.Last_equipped == 1:
			var shotgun = Shotgun_path.instantiate()
			add_child(shotgun)
		
	if GameTracker.player_health <= 0.0:
		queue_free()

func Buildings():
	if Input.is_action_just_pressed("1_Build"):
		$Building_UI.set_chosen_build(1)
	if Input.is_action_just_pressed("2_Build"):
		$Building_UI.set_chosen_build(2)
	if Input.is_action_just_pressed("3_Build"):
		$Building_UI.set_chosen_build(3)

func WeaponSwitching():
	if Current_weapon == Weapons.Pistol and not has_node("Pistol"):
		var Pistol = Pistol_path.instantiate()
		add_child(Pistol)
		var shotgun = get_node("Shotgun")
		shotgun.queue_free()
		GameTracker.Last_equipped = 0
		print("Pistol")
		
	if Current_weapon == Weapons.Shotgun and not has_node("Shotgun"):
		var Shotgun = Shotgun_path.instantiate()
		add_child(Shotgun)
		var pistol = get_node("Pistol")
		pistol.queue_free()
		GameTracker.Last_equipped = 1
		print("Shotguna")
	print("AGHAGHHA")

func _process(delta: float) -> void:
	print("LIFEAOKAY?",invuln)
	$FacingPivot.look_at(get_global_mouse_position())

func Apply_Knockback(KB_Source, KB_Strength):
	var KB_dir = KB_Source.direction_to(global_position)
	KB = KB_dir * KB_Strength

func Dash(dir,strength):
	KB = dir * strength

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy_Normal") and not invuln:
		print("IS IN")
		GameTracker.player_health -= NormalEnemy_dmg
		Apply_Knockback(body.position,750)
		invuln = true
		$Invuln.start()
		
	#if body.has_method("Apply_Knockback"):
		#body.Apply_Knockback(global_position,500)
	#pass # Replace with function body.


func _on_invuln_timeout() -> void:
	invuln = false
	pass # Replace with function body.
