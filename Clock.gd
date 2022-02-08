extends Node2D

var time

# Called when the node enters the scene tree for the first time.
func _ready():
	time = OS.get_time()
	if(time.hour < 10):
		$Hours.text = "0" + str(time.hour)
	else:
		$Hours.text = str(time.hour)
		
	
	if(time.minute < 9):
		$Minutes.text = "0" + str(time.minute)
	else:
		$Minutes.text = str(time.minute)
		

func _process(delta):
	time = OS.get_time()
	$Hours.text = str(time.hour)
	if(time.minute < 9):
		$Minutes.text = "0" + str(time.minute)
	else:
		$Minutes.text = str(time.minute)
