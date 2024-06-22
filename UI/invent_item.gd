extends Control

var item_name = ""
var item_amount = 0
var properties = {}
var inventory = null

@onready var inventory_owner = null

func set_item(item_name, amount, props):
	self.item_name = item_name
	self.item_amount = amount
	self.properties = props.duplicate()
	$ColorRect.visible = false
	$TextureRect.texture = load("res://UI/item_sheet.png/%s.png" % item_name)
	$Amount.text = str(amount)

func get_item_name():
	return item_name

func add_amount(am):
	item_amount += am
	$Amount.text = str(item_amount)

func get_amount():
	return item_amount

func set_amount(val):
	item_amount = val
	
func get_props():
	return properties

func set_inventory(val):
	inventory = val

func set_invent_owner(own):
	inventory_owner = own

#func remove_amount(am):
	#item_amount -= am
	#$Amount.text = str(item_amount)
	#if item_amount == 0:
		#inventory.remove_item(self)

func can_stack():
	return properties["can_stack"]

func save():
	return [item_name, item_amount, properties]

func _on_button_pressed():
	$ColorRect.visible = !$ColorRect.visible

func _on_drop_pressed():
	inventory.get_inv_owner().drop_item(self)
