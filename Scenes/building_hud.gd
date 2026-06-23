extends CanvasLayer

@onready var NS = $NS
@onready var M = $M
@onready var HS = $HS

const  NS_path = preload("res://Scenes/build_preview.tscn")
const CR_path = preload("res://Scenes/crafting_preview.tscn")
const M_path = preload("res://Assets/landmine_preview.tscn")

var current_chosen_build : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NS.hide()
	$M.hide()
	$HS.hide()
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if GameTracker.scrap_amt >= 3:
		if current_chosen_build != 1:
			$NS/CanvasModulate.color = Color(1.0, 1.0, 1.0)
	else:
		$NS/CanvasModulate.color = Color(0.796, 0.173, 0.141, 1.0)

	if GameTracker.scrap_amt >= 3:
		if current_chosen_build != 2:
			$M/CanvasModulate.color = Color(1.0, 1.0, 1.0)
	else:
		$M/CanvasModulate.color = Color(0.796, 0.173, 0.141, 1.0)

	if GameTracker.scrap_amt >= 1:
		if current_chosen_build != 3:
			$HS/CanvasModulate.color = Color(1.0, 1.0, 1.0)
	else:
		$HS/CanvasModulate.color = Color(0.796, 0.173, 0.141, 1.0)


func set_chosen_build(build_num):
	#print("HERES IS IT ITS IS", build_num)
	if current_chosen_build == build_num:
		return
	current_chosen_build = build_num
	for Weapon in get_tree().get_nodes_in_group("Weapon"):
		Weapon.queue_free()
	if current_chosen_build == 0:
		return
	match build_num:
		1:
			if GameTracker.scrap_amt >= 3:
				for Build in get_tree().get_nodes_in_group("Building"):
					Build.queue_free()
				var NS_preview = NS_path.instantiate()
				get_parent().add_child(NS_preview)
				$NS/CanvasModulate.color = Color(2.454, 2.454, 2.454, 1.0)
				$HS/CanvasModulate.color = Color(1.0, 1.0, 1.0, 1.0)
				$M/CanvasModulate.color = Color(1.0, 1.0, 1.0, 1.0)
		2:
			if GameTracker.scrap_amt >= 3:
				for Build in get_tree().get_nodes_in_group("Building"):
					Build.queue_free()
				var M_preview = M_path.instantiate()
				get_parent().add_child(M_preview)
				$M/CanvasModulate.color = Color(2.454, 2.454, 2.454, 1.0)
				$HS/CanvasModulate.color = Color(1.0, 1.0, 1.0, 1.0)
				$NS/CanvasModulate.color = Color(1.0, 1.0, 1.0, 1.0)
		3:
			if GameTracker.scrap_amt >= 1:
				for Build in get_tree().get_nodes_in_group("Building"):
					Build.queue_free()
				var CR_preview = CR_path.instantiate()
				get_parent().add_child(CR_preview)
				$HS/CanvasModulate.color = Color(2.454, 2.454, 2.454, 1.0)
				$NS/CanvasModulate.color = Color(1.0, 1.0, 1.0, 1.0)
				$M/CanvasModulate.color = Color(1.0, 1.0, 1.0, 1.0)
