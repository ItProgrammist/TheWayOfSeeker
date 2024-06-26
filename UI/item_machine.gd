extends Node

@onready var item = preload("res://UI/item.tscn")

var items = {
	"1" : ["1", 8, {"can_stack" : true, "function" : "put_on"}],
	"2" : ["2", 8, {"can_stack" : true, "function" : "put_on"}],
	"4" : ["4", 8, {"can_stack" : true, "function" : "put_on"}],
	"5" : ["5", 8, {"can_stack" : true, "function" : "put_on"}],
	"7" : ["7", 8, {"can_stack" : true, "function" : "put_on"}],
	"27" : ["27", 8, {"can_stack" : true}],
	"125" : ["125", 8, {"can_stack" : true, "function": "jump", "expandable": true, "exp_rate": 1}],
	"115" : ["115", 8, {"can_stack" : true, "function": "speed", "expandable": true, "exp_rate": 1}],
	"135" : ["135", 8, {"can_stack" : true, "function": "heal", "heal_val": 10, "expandable": true, "exp_rate": 1}],
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

