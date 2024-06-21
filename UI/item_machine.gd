extends Node

@onready var item = preload("res://UI/item.tscn")

var items = {
	"1" : ["1", 8, {"can_stack" : true}],
	"2" : ["2", 8, {"can_stack" : true}],
	"3" : ["3", 8, {"can_stack" : true}],
	"4" : ["4", 8, {"can_stack" : true}],
	"5" : ["5", 8, {"can_stack" : true}],
	"6" : ["6", 8, {"can_stack" : true}],
	"7" : ["7", 8, {"can_stack" : true}],
	"8" : ["8", 8, {"can_stack" : true}],
	"9" : ["9", 8, {"can_stack" : true}],
	"10" : ["10", 8, {"can_stack" : true}],
}

func has_item(item_name):
	return item_name in items.keys()

func generate_item(item_name, item_amount = 1):
	if has_item(item_name):
		var new_item = item.instantiate()
		new_item.set_item(items[item_name])
		new_item.set_amount(item_amount)
		return new_item
	return null

func get_item_properties(item_name):
	if has_item(item_name):
		return items[item_name]
	return []

