extends Node2D

@onready var pipe_spawner = $PipeSpawner
@onready var score_label = $UI/ScoreLabel

var pipe_scene = preload("res://pipe_pair.tscn")
var score = 0
var game_over = false
var can_restart = false

func game_over_game():
	game_over = true
	pipe_spawner.stop()
	
	$GameOverSound.play()
	
	await get_tree().create_timer(1.0).timeout
	can_restart = true
	
func _on_pipe_spawner_timeout() -> void:
	var pipe = pipe_scene.instantiate()
	var random_y = randi_range(200, 400)
	pipe.position = Vector2(1200, random_y)
	add_child(pipe)
	
func _process(delta):
	if game_over and can_restart and Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()
	
func add_score():
	if game_over:
		return
		
	score += 1
	score_label.text = str(score)
	
	$ScoreSound.play()
