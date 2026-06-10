extends CharacterBody2D

const GRAVITY = 1000.0
const JUMP_FORCE = -350.0

var is_dead = false
var screen_height = get_viewport_rect().size.y

@onready var game_over_label = $"../UI/GameOverLabel"
@onready var flap_sound = get_parent().get_node("FlapSound")
@onready var game_over_sound = get_parent().get_node("GameOverSound")

func _ready() -> void:
	$Fly.play()
	z_index = 10

func _physics_process(delta):
	
	var screen_size = get_viewport_rect().size
	
	if position.y < 0 or position.y > screen_size.y:
		die()
	
	velocity.y += GRAVITY * delta

	if !is_dead and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_FORCE
		flap_sound.play()

	rotation = deg_to_rad(clamp(velocity.y * 0.08, -30, 90))
	
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		die()
		
func die():
	if is_dead:
		return
	
	is_dead = true
	game_over_label.visible = true
	game_over_sound.play()
	get_parent().game_over_game()
	
	$CollisionShape2D.disabled = true
	set_collision_layer(0)
	set_collision_mask(0)
	
	velocity.y = 200.0
