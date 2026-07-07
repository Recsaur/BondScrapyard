extends GPUParticles2D
var hit = AudioHandler.get_node("Empty")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#restart()
	emitting = true
	hit.pitch_scale = randf_range(0.85,1.15)
	hit.play()

func _on_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
