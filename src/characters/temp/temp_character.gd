extends Node2D

@onready var anim_player = $AnimationPlayer
@onready var anim_tree = $AnimationTree
@onready var anim_state_machine = anim_tree["parameters/playback"]
@onready var arm_collider = $StaticBody2D
@onready var arm_collider_anchor = $Skeleton2D/TorsoBone/UpperArmFrontBone/ForearmFrontBone/ColliderAnchor
@onready var arm_target = $IKTargets/ArmTarget

var squat_input_strength = 0.2
var squat_loss_rate = 0.012
var squat_drop_rate = 0.02

var last_input_action: String

# TODO - make this a state machine
var is_squatting: bool = true
var is_walking: bool = false

# 
var thighs_active: bool = false
var calves_active: bool = false


func _ready():
	anim_tree.active = true
	anim_state_machine.start("squat")


func _input(event):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()


func _physics_process(delta):
	arm_target.global_position = get_global_mouse_position()
	arm_collider.global_position = arm_collider_anchor.global_position


func _process(delta):
	if is_squatting:
		var current_blend_pos = anim_tree["parameters/squat/blend_position"]
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
			"parameters/squat/blend_position", 
			new_blend_pos
		)
		print(anim_tree["parameters/squat/blend_position"])
		if new_blend_pos == 1.0:
			is_squatting = false
			is_walking = true
			anim_tree.active = false
			anim_player.play("walk")
	elif is_walking:
		pass
