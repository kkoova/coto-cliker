extends Control

@export var coin_label: Label
@export var upgrade_container: VBoxContainer

func _ready() -> void:
	check_purchased_upgrades()

func update_ui() -> void:
	coin_label.text = str(Global.coin)

func _on_down_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func close_button(name_button: NodePath):
	var button = get_node(name_button) as Button
	if button:
		button.disabled = true
		if not Global.purchased_upgrades.has(name_button):
			Global.purchased_upgrades.append(name_button)

func check_purchased_upgrades() -> void:
	coin_label.text = str(Global.coin)
	for button_path in Global.purchased_upgrades:
		var button = get_node_or_null(button_path) as Button
		if button:
			button.disabled = true

func _on_tree_level_coin_button_pressed(extra_arg_0: NodePath, extra_arg_1: int, extra_arg_2: int) -> void:
	if Global.coin < extra_arg_1:
		return
	Global.coin -= extra_arg_1
	Global.coin_per_second = extra_arg_2
	close_button(extra_arg_0)

func _on_auto_level_coin_button_pressed(extra_arg_0: NodePath) -> void:
	if Global.coin < 150:
		return
	Global.coin -= 150
	Global.auto_coin = true
	close_button(extra_arg_0)
