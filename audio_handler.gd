extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func PitchVerity(GivenAudio):
	if GivenAudio == null:
		return null
	GivenAudio.pitch_scale = randf_range(0.85,1.15)
	return GivenAudio
