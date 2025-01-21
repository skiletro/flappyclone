extends Node2D

@onready var original_position = position.y
@export var float_height = 10
var unsmoothed_position = float_height
var velocity = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Reverse the position when it meets the boundaries
	if unsmoothed_position > float_height or unsmoothed_position < -float_height:
		velocity = -velocity
		
	unsmoothed_position += velocity * (delta * 15)
	
	position.y = original_position + unsmoothed_position
