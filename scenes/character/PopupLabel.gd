extends Node2D

var text: String

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/Label.text = text
	$Tween.interpolate_property($Control, "rect_scale", Vector2(0, 0), Vector2(.5, .5), .5,Tween.TRANS_CUBIC, Tween.EASE_OUT)
	
	$CPUParticles2D.emitting = true
	$Tween.start()
	
	yield($Tween, "tween_all_completed")
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
