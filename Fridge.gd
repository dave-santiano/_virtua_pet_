extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var onFridge
signal eaten

# Called when the node enters the scene tree for the first time.
func _ready():
	onFridge = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Fridge_mouse_entered():
	onFridge = true
	$AnimatedSprite.animation = "open"
	print("mouse entered fridge")
	
func _input(event):
#	if (Input.is_action_just_released("house_object_select") && onFridge == true):
#		emit_signal("eaten")
	pass	

func _on_Fridge_mouse_exited():
	onFridge = false
	$AnimatedSprite.animation = "closed"
	print("mouse exited fridge")
	
func _on_Fridge_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		if not event.is_pressed():
			var music_player = get_parent().get_node("AudioStreamPlayer")
			if(not music_player.playing):
				music_player.play()
			$AnimatedSprite.animation = "closed"
			emit_signal("eaten")
		if event.is_pressed():
			$AnimatedSprite.animation = "open"
	if event is InputEventMouseButton:
		if not event.is_pressed():
			var music_player = get_parent().get_node("AudioStreamPlayer")
			if(not music_player.playing):
				music_player.play()
			emit_signal("eaten")
			
