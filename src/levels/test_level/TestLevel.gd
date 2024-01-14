extends Node2D

@onready var box_spawn = $BoxSpawn
@onready var box_scene = load("res://src/env/box/box.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("spawn_box"):
		var box = box_scene.instantiate()
		box.global_position = box_spawn.global_position
		add_child(box)
