extends Node

const SAVE_PATH: String = "user://clicker_save.json"

var coin_per_second = 1
var auto_coin = false
var purchased_upgrades: Array[String] = []
var coin = 0

func save_game() -> void:
	var save_data: Dictionary = {
		"coin": coin,
		"coin_per_second": coin_per_second,
		"auto_coin": auto_coin,
		"purchased_upgrades": purchased_upgrades
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null: return
	file.store_string(JSON.stringify(save_data))

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH): return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null: return
	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY: return
	coin = int(parsed.get("coin", 0))
	coin_per_second = int(parsed.get("coin_per_second", 1))
	auto_coin = parsed.get("auto_coin", false)
	var raw_upgrades = parsed.get("purchased_upgrades", [])
	purchased_upgrades = Array(raw_upgrades, TYPE_STRING, &"", null)
	
	get_tree().change_scene_to_file("res://scenes/main.tscn")
