extends Control


func _ready() -> void:
	print(GameState.group1_south_strength)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen/start_screen.tscn")
