extends Node2D

var time
signal clock_touched

# Called when the node enters the scene tree for the first time.
func _ready():
	time = OS.get_time()
	if(time.hour < 10):
		$Hours.text = "0" + str(time.hour)
	else:
		$Hours.text = str(time.hour)
		
	
	if(time.minute < 10):
		$Minutes.text = "0" + str(time.minute)
	else:
		$Minutes.text = str(time.minute)
		

func _process(delta):
	time = OS.get_time()
	$Hours.text = str(time.hour)
	if(time.hour < 10):
		$Hours.text = "0" + str(time.hour)
	else:
		$Hours.text = str(time.hour)
		
	if(time.minute < 10):
		$Minutes.text = "0" + str(time.minute)
	else:
		$Minutes.text = str(time.minute)


func _on_Clock_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		if not event.is_pressed():
			emit_signal("clock_touched")
			var music_player = get_parent().get_node("AudioStreamPlayer")
			if(not music_player.playing):
				music_player.play()
			
	if event is InputEventMouseButton:
		if event.is_pressed():
			self.scale = Vector2(self.scale.x + .1, self.scale.y + .1)
		if not event.is_pressed():
			self.scale = Vector2(self.scale.x - .1, self.scale.y - .1)
			emit_signal("clock_touched")
			var music_player = get_parent().get_node("AudioStreamPlayer")
			if(not music_player.playing):
				music_player.play()
			


func _on_Clock_mouse_entered():
	pass # Replace with function body.
