extends Area2D

@export var bob_height : float = 5.0
@export var bob_speed : float = 5.0

@onready var start_y : float = global_position.y
var t : float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	
	# t = time incremented based on delta time
	# Formula below converts to sine wave movement pattern
	# Multiplying by bob_speed helps speed up and modify rate of bobbing
	# the +1 / 2 portion adds 1 to sine base and divide by 2, to convert range of 1.0 to -1.0 to 1.0 to 0, removing negative range from sine wave
	var d = (sin(t * bob_speed) +1) /2
	global_position.y = start_y + (d * bob_height)
	
# Collect Coin
func _on_body_entered(body):
	if body.is_in_group("Player"):
		
		# Need to check visibility since queue_free() will destroy the object faster than the sound can play
		# workaround is to make object invisible after collection, have audio finish playing, then destroy object on audio play finished
		if visible:
			# play sound effect
			$CoinSound.play()
			# hide object
			visible = false
			# increase score
			body.add_score(1)
				
		# await to allow sound effect to finish playing before destroy
		await $CoinSound.finished
		
		# Destroy coin
		queue_free()
		print("Coin destroyed")
