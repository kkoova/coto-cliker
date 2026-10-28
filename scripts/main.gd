extends Control

@export var coins_label: Label
@export var anim: AnimatedSprite2D
@export var level_ui: HBoxContainer
@export var level_ui_texture: Texture
@export var timer_coin: Timer
@export var click_sound: AudioStreamPlayer

const FLOATING_TEXT_SCENE = preload("res://scenes/float.tscn")

func _ready() -> void:
	update_ui()
	update_ui_level()
	if Global.auto_coin:
		timer_coin.start()

func _on_click_button_pressed() -> void:
	anim.play("happy")
	click_sound.pitch_scale = randf_range(0.9, 1.1)
	click_sound.play()
	Global.coin += Global.coin_per_second
	if Global.coin > 999: Global.coin = 0
	update_ui()
	ui_label()


func update_ui_level() -> void:
	for i in range(Global.coin_per_second / 2):
		var slot = TextureRect.new()
		slot.texture = level_ui_texture
		slot.stretch_mode = TextureRect.STRETCH_KEEP
		level_ui.add_child(slot)

func ui_label():
	var text_instance = FLOATING_TEXT_SCENE.instantiate()
	text_instance.text = "+" + str(Global.coin_per_second)
	add_child(text_instance)
	var random_x = randi_range(20, 100)
	var random_y = randi_range(80, 150)
	
	text_instance.position = Vector2(random_x, random_y)

func update_ui() -> void:
	coins_label.text = str(Global.coin)

func _on_animated_sprite_2d_animation_finished() -> void:
	anim.play("idle")

func _on_shop_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop.tscn")

func _on_timer_timeout() -> void:
	Global.coin += Global.coin_per_second
	update_ui()
	ui_label()

func _on_pause_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/paise.tscn")
