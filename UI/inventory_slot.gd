extends Control

var item_name = ""
var item_amount = 0
var properties = {}

func set_item(item_name, amount, props):
	self.item_name = item_name
	self.item_amount = amount
	self.properties = props.duplicate()
	
	$ColorRect2/Sprite2D.texture = load("res://UI/item_sheet.png/%s.png" % item_name)
	$ColorRect2/Label.text = str(amount)

func get_item_name():
	return item_name

func add_amount(am):
	item_amount += am
	$ColorRect2/Label.text = str(item_amount)

func get_amount():
	return item_amount
	
func get_props():
	return properties

func can_stack():
	return properties["can_stack"]

func save():
	return [item_name, item_amount, properties]

func _on_button_pressed():
	if item_amount != 0:
		$ColorRect3.visible = !$ColorRect3.visible
		
func set_empty():
	$ColorRect2/Sprite2D.texture = null
	$ColorRect2/Label.text = ""
