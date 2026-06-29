extends Node2D
const maingame = preload("res://Scenes/Maps/Map.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_mouse_entered() -> void:
	$Play.font_size += 50
	pass # Replace with function body.


func _on_play_button_mouse_entered() -> void:
	var tween = create_tween()
	#var tweenfont = create_tween()
	#tweenfont.tween_property($PlayText.label_settings,"font_size",128,0.15)
	#$PlayText.label_settings.font_size = 128
	tween.tween_property($PlayColor,"color",Color(0.384, 0.384, 0.384),0.15)
	pass # Replace with function body.


func _on_play_button_mouse_exited() -> void:
	var tween = create_tween()
	#$PlayText.label_settings.font_size = 96
	tween.tween_property($PlayColor,"color",Color(0.384, 0.384, 0.384, 0.0),0.25)
	pass # Replace with function body.


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(maingame)
