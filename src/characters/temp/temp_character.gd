extends Node2D

@onready var anim_tree = $AnimationTree

var squat_input_strength = 0.2
var squat_loss_rate = 0.012
var squat_drop_rate = 0.02

var last_input_action: String

var is_squatting: bool = true


func _process(delta):
	if is_squatting:
		var current_blend_pos = anim_tree["parameters/blend_position"]
		var new_blend_pos: float = current_blend_pos - squat_loss_rate
		
		if Input.is_action_just_released("squat_left"):
			if not last_input_action == "squat_left":
				new_blend_pos += squat_input_strength
				new_blend_pos -= squat_loss_rate
				last_input_action = "squat_left"
		elif Input.is_action_just_released("squat_right"):
			if not last_input_action == "squat_right":
				new_blend_pos += squat_input_strength
				new_blend_pos -= squat_loss_rate
				last_input_action = "squat_right"
		
		new_blend_pos -= squat_loss_rate
		new_blend_pos = clamp(new_blend_pos, -1, 1)
		
		anim_tree.set(
			"parameters/blend_position", 
			new_blend_pos
		)
		print(anim_tree["parameters/blend_position"])
		if new_blend_pos == 1.0:
			is_squatting = false
		
