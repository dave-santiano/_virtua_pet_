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
	print("mouse entered fridge")
	
func _input(event):
	if (Input.is_action_just_released("house_object_select") && onFridge == true):
		emit_signal("eaten")
		print("EATEN")

func _on_Fridge_mouse_exited():
	onFridge = false
	print("mouse exited fridge")
	
