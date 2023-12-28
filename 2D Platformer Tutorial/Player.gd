extends CharacterBody2D

# Movement variables
@export var move_speed : float = 100.0
@export var jump_force : float = 200.0
var gravity : float = 500.0

# Score
var score : int = 0
@onready var score_text : Label = get_node("CanvasLayer/ScoreText")

# Physics based function - required for character movement
func _physics_process(delta):
	
	# Check if player is on floor
	if not is_on_floor():
		velocity.y += gravity * delta
		
	velocity.x = 0
	
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x -= move_speed
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x += move_speed
	
	# Jump
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = -jump_force
		$Jump.play()
	
	# Move player
	move_and_slide()
	
# Enters Death Pit Area
#func _on_death_pit_body_entered(body):
	#print("Dead")
	#_game_over()

# Game Over
func _game_over():
	get_tree().reload_current_scene()

func add_score (amount):
	score += amount
	score_text.text = str("Score: ", score)
