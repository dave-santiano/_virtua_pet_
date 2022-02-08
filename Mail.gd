extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal mail_clicked
var on_mail

# Called when the node enters the scene tree for the first time.
func _ready():
	on_mail = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if (Input.is_action_just_released("house_object_select") && on_mail == true):
		emit_signal("mail_clicked")

func _on_Mail_mouse_entered():
	on_mail = true

func _on_Mail_mouse_exited():
	on_mail = false
