tool
extends Sprite

# type declaration
enum LCDDisableType { ALPHA, DISABLE }
var LCDSprite = get_script()

# constants
const offSpriteAlpha = 0.2

# exported variables
export var isHeadNode = false
export(LCDDisableType) var offBehavior = LCDDisableType.ALPHA

# non-exported variables
var onColor: Color
var offColor: Color
var childNodes: Dictionary = {}

func _enter_tree():
	onColor = self.get_modulate()
	offColor = self.get_modulate()
	offColor.a = offSpriteAlpha
	
	if isHeadNode:
		generateChildList()

func generateChildList():
	for node in self.get_children():
		if node is LCDSprite:
			childNodes[node.get_name()] = node
			
			if node.get_child_count() > 0:
				node.generateChildList()
				for childKey in node.childNodes.keys():
					childNodes[childKey] = node.childNodes[childKey]

func onNode(node):
	if node is LCDSprite:
		if offBehavior == LCDDisableType.DISABLE:
			node.set_visible(true)
		else:
			node.set_modulate(onColor)

func on():
	onNode(self)

func offNode(node):
	if node is LCDSprite:
		if offBehavior == LCDDisableType.DISABLE:
			node.set_visible(false)
		else:
			node.set_modulate(offColor)

func off():
	offNode(self)