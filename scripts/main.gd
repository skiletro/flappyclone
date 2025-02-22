extends Node2D

@export var pipe_timer : Timer
@export var pipe_scene : Resource
@export var height_variance : int

var game_in_progress = false
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	start_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		$SwooshSound.play()
		start_game()
	
	if game_in_progress:
		for pipe in $Pipes.get_children():
			if pipe.position.x < -55:
				pipe.queue_free() # Delete pipe if it goes out of bounds
			else:
				pipe.position.x = pipe.position.x - 100 * delta # Otherwise, move it along

func start_game() -> void:
	$Bird.reset()
	game_in_progress = true
	$Floor.isMoving = true
	score = 0
	$Counter.update_counter(score)
	
	# Clear all pipes
	get_tree().call_group("pipes", "queue_free")
	
	# Restart the timer
	pipe_timer.start()
	
	$RestartLabel.hide() # Temporary until proper HUD is implemented.
	
func stop_game() -> void:
	game_in_progress = false
	$Bird.isAlive = false
	$Floor.isMoving = false
	pipe_timer.stop()
	$HitSound.play()
	$DieSound.play()
	
	$RestartLabel.show() # Temporary until proper HUD is implemented.

func _on_pipe_timer_timeout() -> void:
	var pipe = pipe_scene.instantiate()
	pipe.hit.connect(_on_pipe_hit)
	pipe.score.connect(_on_pipe_score)
	pipe.position.x = 290
	pipe.position.y = 190 + (randi() % height_variance - (height_variance/2))
	
	# Add the pipe to the scene
	$Pipes.add_child(pipe)

func _on_pipe_hit() -> void:
	if game_in_progress:
		stop_game()
	
func _on_floor_hit() -> void:
	if game_in_progress:
		stop_game()
	
func _on_pipe_score() -> void:
	score += 1
	$Counter.update_counter(score)
	$ScoreSound.play()
