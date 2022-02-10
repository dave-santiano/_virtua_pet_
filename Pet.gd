extends Area2D

export var hunger_level = 150
var sleepiness_level = 100
var time_elapsed
var time
var time_return
var is_hungry
var is_night
var is_sleepy

var on_pet

var is_moving

var screen_size
var random_position
var velocity

var dummy_messages = ["Hey! I miss you :D", "Take it easy on yourself!", "Jury summons"]
var interaction_phrases = ["Hey there!", "Hi!", "What's up?", "I could use a chair", "I wonder if there's any mail today?", "Sam is feeding me more, you know."]

func _ready():
	screen_size = get_viewport_rect().size
	is_moving = false
	is_hungry = false
	is_sleepy = false
	on_pet = false
	velocity = Vector2.ZERO
	$LetterSendMenu.hide()


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
		sleepiness_level = 0
		is_sleepy = true
		is_moving = false
	else:
		is_sleepy = false

		
		

func _input(event):
	pass
#	if(Input.is_action_just_released("house_object_select") && on_pet == true):
#		$DialogueBox.talk(["Hey there!"])
#		$LetterSendMenu.show()

func _on_Main_afternoon_started():
	pass # Replace with function body.

func _on_Main_message_received():
	randomize()
	var random_choice = rand_range(0, 3)
	$DialogueBox.talk(["You received a message!", dummy_messages[random_choice] + '\n' + "-Sam", "It's nice to get letters."])

func _on_DialogueBox_dialogue_exit():
	pass # Replace with function body.

func _on_HungerMessageTimer_timeout():
	$DialogueBox.talk(["I'm hungry", "Please feed me!"])
	if not $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()
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
	if event is InputEventScreenTouch:
		if not event.is_pressed():
			var music_player = get_parent().get_node("AudioStreamPlayer")
			if(not music_player.playing):
				music_player.play()
			randomize()
			var casual_dialogue_roll = rand_range(0, 6)
			$DialogueBox.talk(interaction_phrases[casual_dialogue_roll])
#			$LetterSendMenu/SendLetter.show()
	if event is InputEventMouseButton:
		if not event.is_pressed():
			var music_player = get_parent().get_node("AudioStreamPlayer")
			if(not music_player.playing):
				music_player.play()
			randomize()
			var casual_dialogue_roll = rand_range(0, 6)
			$DialogueBox.talk([interaction_phrases[casual_dialogue_roll]])
		
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
	if(is_moving && not is_sleepy):
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
		if(is_hungry && not is_sleepy):
			$AnimatedSprite.animation = "sad"
			velocity = Vector2.ZERO
		elif(is_sleepy):
			$AnimatedSprite.animation = "sleepy"
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


func _on_SendLetter_pressed():
	$DialogueBox.talk(["Oh! You want to send a letter?"])
	$LetterSendMenu.hide()
	

func _on_LetterSend_focus_entered():
	if Input.is_action_pressed("ui_accept"):
		$LetterSendMenu/LetterSend.text = ""
		$LetterSendMenu.hide()


func _on_Clock_clock_touched():
	var time = OS.get_time()
	if(time.minute < 10):
		$DialogueBox.talk(["It's 06:" + "0" +  str(time.minute)+ "PM where Sam is.", "It is also raining over there!", "Tell him to use an umbrella."])
	else:	
		$DialogueBox.talk(["It's 06:" + str(time.minute) + "PM where Sam is.", "It is also raining over there!", "Tell him to use an umbrella."])


func _on_Egg_hatched():
	self.show()
	self.position.x = get_viewport_rect().size.x / 2
#	self.position.x = 
