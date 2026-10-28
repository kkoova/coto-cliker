extends Control

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_save_button_pressed() -> void:
	Global.save_game()

func _on_continue_button_pressed() -> void:
	Global.load_game()
