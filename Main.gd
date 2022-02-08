extends Node

var time
var got_message

var DEBUG_MODE_ON

signal night_started
signal morning_started
signal afternoon_started
signal message_received



var device_ip_address
onready var server_ip_address = $Server_ip_address

func _ready():
	time = OS.get_time()
	DEBUG_MODE_ON = false
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	
	print(device_ip_address)

func _process(delta):
	if(DEBUG_MODE_ON):
#		$DebugText.text = str($Pet.hunger_level + '\n' + $Pet.sleepiness_level)
		$DebugText.text = "Hunger level: " + str($Pet.hunger_level) + '\n' + "Sleepiness level: " + str($Pet.sleepiness_level) + '\n' + str(device_ip_address)
		$JoinServer.show()
		$Server_ip_address.show()
		$CreateServer.show()
#		print($DebugText.)
#		$DebugText.text = "TEST DEBUG"
	else:
		$JoinServer.hide()
		$Server_ip_address.hide()
		$CreateServer.hide()
		$DebugText.text = ""
	
	if(time.hour >= 20 || time.hour < 6):
		$Background.animation = "night"
		emit_signal("night_started")
	
	elif(time.hour >= 6 && time.hour < 13):
		$Background.animation = "day"
		emit_signal("morning_started")
	
	elif(time.hour >= 13 && time.hour < 20):
		$Background.animation = "afternoon"
		emit_signal("afternoon_started")
		
#	if(got_message):
#		emit_signal("message_received")
	
func _input(event):
	if(Input.is_action_just_pressed("random_message_dummy_send")):
#		read_dummy_message()
		$Mail.show()
		got_message = true
	
func _on_Button_button_up():
	DEBUG_MODE_ON = not DEBUG_MODE_ON
	
func _player_connected(id) -> void:
	print("Player " + str(id) + " has connected")
	
func _player_disconnected(id) -> void:
	print("Player " + str(id) + " has disconnected")
	
func create_server():
	Network.create_server()
	device_ip_address = Network.ip_address
	
func join_server():
	if server_ip_address.text != "":
		print(server_ip_address.text)
		Network.ip_address = int(server_ip_address.text)
		Network.join_server()

func _on_CreateServer_pressed():
	create_server()

func _on_JoinServer_pressed():
	join_server()

func read_dummy_message():
	var random_choice = rand_range(0, 3)

func _on_Mail_mail_clicked():
	emit_signal("message_received")
	$Mail.hide()
	
