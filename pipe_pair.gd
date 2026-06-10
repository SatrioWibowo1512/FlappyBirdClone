extends Node2D

const SPEED = 200.0

func _process(delta):
	if get_parent().game_over:
		return
	
	position.x -= SPEED * delta
	
	if position.x < -100:
		queue_free()

func _on_score_area_body_entered(body: Node2D) -> void:
	if body.name == "Bird":
		get_parent().add_score()
