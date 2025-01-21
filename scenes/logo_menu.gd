extends Node2D

@onready var original_position = position.y
@export var float_height = 10
var velocity = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Reverse the position when it meets the boundaries
	if position.y >= (original_position + float_height) or position.y <= (original_position - float_height):
		velocity = -velocity
	
	position.y += velocity * (delta * 10)
