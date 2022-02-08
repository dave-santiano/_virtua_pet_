extends Area2D

export var hunger_level = 100
var sleepiness_level = 100
var time_elapsed
var time
var time_return
var is_hungry
var is_night

var on_pet

var is_moving

var screen_size
var random_position
var velocity

var dummy_messages = ["Hey! I miss you :D", "Take it easy on yourself!", "Jury summons"]
var interaction_phrases = ["Hey there! Nice to see you", "Sam is doing great from what I hear!"]

func _ready():
	screen_size = get_viewport_rect().size
	is_moving = false
	is_hungry = false
	on_pet = false
	velocity = Vector2.ZERO

func _process(delta):
	idle_movement(delta)
	if(hunger_level <= 60):
		if(not is_hungry):
			is_hungry = true
			is_moving = false
			$MovementTimer.stop()
			$HungerMessageTimer.start()
			
		if(hunger_level <= 0):
			hunger_level = 0
	else:
		is_hungry = false
		if(not $HungerMessageTimer.is_stopped()):
			$HungerMessageTimer.stop()
			
		if($MovementTimer.is_stopped()):
			$MovementTimer.start()
		
		
	if(sleepiness_level <= 20):
#		print("passed out")
		if(sleepiness_level <= 0):
			sleepiness_level = 0

func _input(event):
	if(Input.is_action_just_released("house_object_select") && on_pet == true):
		$DialogueBox.talk(["Hey there!"])

func _on_Main_afternoon_started():
	pass # Replace with function body.

func _on_Main_message_received():
	randomize()
	var random_choice = rand_range(0, 3)
	$DialogueBox.talk(["You received a message!", dummy_messages[random_choice], "Okay, goodbye!"])

func _on_DialogueBox_dialogue_exit():
	pass # Replace with function body.

func _on_HungerMessageTimer_timeout():
	$DialogueBox.talk(["I'm hungry", "Please feed me!"])
	$AnimatedSprite.animation = "sad"

func _on_Main_night_started():
	pass # Replace with function body.

func _on_HungerLevelTimer_timeout():
	hunger_level -= 10

func _on_SleepLevelTimer_timeout():
	sleepiness_level -= 10

func _on_Fridge_eaten():
	hunger_level += 50

func _on_Pet_input_event(viewport, event, shape_idx):
	#TO-DO add some casual dialogue from the pet
	pass
		
func _on_MovementTimer_timeout():
	randomize()
	var movement_behavior_roll = rand_range(0, 1)
	random_position  = rand_range(0, screen_size.x)
#	print(random_position)
	if(movement_behavior_roll < 0.5):
		is_moving = false
	else:
		is_moving = true
#	print("Moving = " + str(is_moving))
#	print($AnimatedSprite.animation)

func idle_movement(delta):
	if(is_moving):
		velocity = Vector2.ZERO
		if(position.x - random_position > 0):
			$AnimatedSprite.animation = "left"
#			print($AnimatedSprite.animation)
			
			velocity.x -= 1
			position += velocity
			if(position.x - random_position < 0):
				is_moving = false
			
		elif(position.x - random_position < 0):
			$AnimatedSprite.animation = "right"
			velocity.x += 1
			position += velocity
			if(position.x - random_position > 0):
				is_moving = false
				
		position.x = clamp(position.x, 0, screen_size.x)
		
	else:
		if(is_hungry):
			$AnimatedSprite.animation = "sad"
			velocity = Vector2.ZERO
		else:
			$AnimatedSprite.animation = "idle"
			velocity = Vector2.ZERO


func _on_Pet_mouse_entered():
	on_pet = true
	print(on_pet)


func _on_Pet_mouse_exited():
	on_pet = false
	print(on_pet)
	
