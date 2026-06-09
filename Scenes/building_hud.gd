extends CanvasLayer

@onready var NS = $NS
@onready var M = $M
@onready var HS = $HS

var Chosen_1 = false
var Chosen_2 = false
var Chosen_3 = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if GameTracker.scrap_amt >= 3:
		$NS/CanvasModulate.color = Color(1.0, 1.0, 1.0)
		if Chosen_1:
			ChosenBuild(1)
	else:
		$NS/CanvasModulate.color = Color(0.796, 0.173, 0.141, 1.0)

	if GameTracker.scrap_amt >= 3:
		$M/CanvasModulate.color = Color(1.0, 1.0, 1.0)
		if Chosen_2:
			ChosenBuild(2)
	else:
		$M/CanvasModulate.color = Color(0.796, 0.173, 0.141, 1.0)

	if GameTracker.scrap_amt >= 5:
		$HS/CanvasModulate.color = Color(1.0, 1.0, 1.0)
		if Chosen_3:
			ChosenBuild(3)
	else:
		$HS/CanvasModulate.color = Color(0.796, 0.173, 0.141, 1.0)

func ChosenBuild(Build_num):
	match Build_num:
		1:
			$NS/CanvasModulate.color = Color(2.454, 2.454, 2.454, 1.0)
			$HS/CanvasModulate.color = Color(1.0, 1.0, 1.0, 1.0)
			$M/CanvasModulate.color = Color(1.0, 1.0, 1.0, 1.0)
		2:
			$M/CanvasModulate.color = Color(2.454, 2.454, 2.454, 1.0)
			$HS/CanvasModulate.color = Color(1.0, 1.0, 1.0, 1.0)
			$NS/CanvasModulate.color = Color(1.0, 1.0, 1.0, 1.0)
		3:
			$HS/CanvasModulate.color = Color(2.454, 2.454, 2.454, 1.0)
			$NS/CanvasModulate.color = Color(1.0, 1.0, 1.0, 1.0)
			$M/CanvasModulate.color = Color(1.0, 1.0, 1.0, 1.0)
