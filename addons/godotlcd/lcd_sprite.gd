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
	childNodes[self.get_name()] = self

	for node in self.get_children():
		if node is LCDSprite:
			childNodes[node.get_name()] = node
			
			if node.get_child_count() > 0:
				node.generateChildList()
				for childKey in node.childNodes.keys():
					childNodes[childKey] = node.childNodes[childKey]
	print(childNodes)

func onNode(nodeName):
	if childNodes.has(nodeName):
		if offBehavior == LCDDisableType.DISABLE:
			childNodes[nodeName].set_visible(true)
		else:
			childNodes[nodeName].set_modulate(onColor)

func on():
	onNode(self.get_name())

func offNode(nodeName):
	if childNodes.has(nodeName):
		if offBehavior == LCDDisableType.DISABLE:
			childNodes[nodeName].set_visible(false)
		else:
			childNodes[nodeName].set_modulate(offColor)

func off():
	offNode(self.get_name())