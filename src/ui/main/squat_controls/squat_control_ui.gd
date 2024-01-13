extends Control

@onready var squat_left_texture: TextureRect = $MarginContainer/HBoxContainer/MarginContainer/TextureRect
@onready var squat_right_texture: TextureRect = $MarginContainer/HBoxContainer/MarginContainer3/TextureRect


func _process(_delta):
	var _texture_to_press: TextureRect
	if Input.is_action_just_pressed("squat_left"):
		_flash_texture_rect(squat_left_texture)
	elif Input.is_action_just_pressed("squat_right"):
		_flash_texture_rect(squat_right_texture)


func _flash_texture_rect(texture_rect: TextureRect, flash_time: float = 0.1):
	var original_modulate: Color = texture_rect.modulate
	var flash_modulate: Color = original_modulate + Color(0.2, 0.3, 0.2)
	texture_rect.modulate = flash_modulate
	await get_tree().create_timer(flash_time).timeout
	texture_rect.modulate = original_modulate

