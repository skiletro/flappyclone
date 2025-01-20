extends Area2D

signal hit

var isMoving = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isMoving:
		if $Sprite2D.position.x <= -47:
			$Sprite2D.position.x = 0
		else:
			$Sprite2D.position.x += -100 * delta

func _on_body_entered(body: CharacterBody2D) -> void:
	hit.emit()
