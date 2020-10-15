extends TextureProgress

const RESOLUTION = 10

export(float) var max_health = 10
var health: float setget _set_health


# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = max_health * RESOLUTION * 1.25
	self.health = max_health


func _set_health(new_health):
	health = new_health
	print("new health " +str(new_health))
	$Tween.interpolate_property(self, "value", float(value), float(health * RESOLUTION), 0.5,Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.connect("tween_step", self, "step")
	$Tween.start()
