tool
extends Sprite

const offSpriteAlpha = 0.2
enum LCDDisableType { ALPHA, DISABLE }

export(LCDDisableType) var offBehavior = LCDDisableType.ALPHA

var onColor: Color
var offColor: Color

func _enter_tree():
	onColor = self.get_modulate()
	offColor = self.get_modulate()
	offColor.a = offSpriteAlpha

func on():
	if (offBehavior == LCDDisableType.DISABLE):
		self.set_visible(true)
	else:
		self.set_modulate(onColor)

func off():
	if (offBehavior == LCDDisableType.DISABLE):
		self.set_visible(false)
	else:
		self.set_modulate(offColor)