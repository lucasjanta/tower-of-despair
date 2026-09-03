extends Control


func _on_new_game_button_pressed() -> void:
	Global.scene_manager.change_gui_scene("res://scenes/misc/reset/resetUI.tscn", true, false)
	Global.scene_manager.change_2D_scene("res://scenes/test_combat_scene.tscn", true, false)
