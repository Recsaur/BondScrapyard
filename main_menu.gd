extends Node2D
const maingame = preload("res://Scenes/Maps/Map.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	#make cool transition here 'kay
	get_tree().change_scene_to_packed(maingame)
