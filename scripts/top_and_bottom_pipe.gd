extends Area2D

signal hit
signal score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: CharacterBody2D) -> void:
	hit.emit()


func _on_score_area_body_entered(body: CharacterBody2D) -> void:
	score.emit()
