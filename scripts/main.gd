extends Node2D

@export var pipe_timer : Timer
@export var pipe_scene : Resource
@export var height_variance : int

var game_in_progress = false
var score = 0
var pipes : Array

@onready var originalBirdPosition = Vector2($Bird.position.x, $Bird.position.y)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	start_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		start_game()
	
	if game_in_progress:
		for pipe in pipes:
			pipe.position.x = pipe.position.x - 100 * delta

func start_game() -> void:
	$Bird.position = originalBirdPosition
	$Bird.rotation = 0
	game_in_progress = true
	$Bird.isAlive = true
	$Floor.isMoving = true
	score = 0
	$Counter.update_counter(score)
	
	# Clear all pipes
	pipes.clear()
	for child in get_children():
		if child.scene_file_path == "res://scenes/top_and_bottom_pipe.tscn":
			child.queue_free()
	pipe_timer.start()
	
func stop_game() -> void:
	game_in_progress = false
	$Bird.isAlive = false
	$Floor.isMoving = false
	pipe_timer.stop()
	$HitSound.play()
	$DieSound.play()

func _on_pipe_timer_timeout() -> void:
	var pipe = pipe_scene.instantiate()
	pipe.hit.connect(_on_hit_pipe)
	pipe.score.connect(_on_pipe_score)
	pipe.position.x = 290
	pipe.position.y = 190 + (randi() % height_variance - (height_variance/2))
	
	# Add the pipe to the scene
	pipes.append(pipe)
	add_child(pipe)

func _on_hit_pipe() -> void:
	if game_in_progress:
		stop_game()
	
func _on_floor_hit() -> void:
	if game_in_progress:
		stop_game()
	
func _on_pipe_score() -> void:
	score += 1
	$Counter.update_counter(score)
	$ScoreSound.play()
