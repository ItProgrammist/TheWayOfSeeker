extends Control

#@onready var items = []
var inventory_owner = null

func set_inv_owner(val):
	inventory_owner = val

func get_inv_owner():
	return inventory_owner

func add_item(item):
	var added = false
	
	if item.can_stack():
		for i in Global.items:
			if i.get_item_name() == item.get_item_name():
				i.add_amount(item.get_amount())
				added = true
				item.queue_free()
				break
	if not item.can_stack() or not added:
		Global.items.append(item)
		item.set_inventory(self)
	
	emit_signal("on_changed")

func get_items():
	return Global.items

func remove_item(link):
	var items = Global.items
	items.remove_at(items.find(link))
	Global.items = items
	link.queue_free()
	emit_signal("on_changed")
