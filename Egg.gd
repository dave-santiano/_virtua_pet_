extends Area2D



var egg_touch_count
var egg_phases = ["egg", "cracked", "hatched"]
var hatching;
signal hatched

func _ready():
	egg_touch_count = 0
	hatching = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Egg_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if not event.is_pressed():
			if(not hatching):
				egg_touch_count += 1
				$AnimatedSprite.animation = egg_phases[egg_touch_count]
				if egg_touch_count >= 2:
					hatching = true
					$AfterHatchTimer.start()


func _on_AfterHatchTimer_timeout():
	self.hide()
	emit_signal("hatched")
