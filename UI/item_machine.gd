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
	"11" : ["11", 8, {"can_stack" : true}],
	"12" : ["12", 8, {"can_stack" : true}],
	"13" : ["13", 8, {"can_stack" : true}],
	"14" : ["14", 8, {"can_stack" : true}],
	"15" : ["15", 8, {"can_stack" : true}],
	"16" : ["16", 8, {"can_stack" : true}],
	"17" : ["17", 8, {"can_stack" : true}],
	"18" : ["18", 8, {"can_stack" : true}],
	"19" : ["19", 8, {"can_stack" : true}],
	"20" : ["20", 8, {"can_stack" : true}],
	"21" : ["21", 8, {"can_stack" : true}],
	"22" : ["22", 8, {"can_stack" : true}],
	"23" : ["23", 8, {"can_stack" : true}],
	"24" : ["24", 8, {"can_stack" : true}],
	"25" : ["25", 8, {"can_stack" : true}],
	"26" : ["26", 8, {"can_stack" : true}],
	"27" : ["27", 8, {"can_stack" : true}],
	"28" : ["28", 8, {"can_stack" : true}],
	"29" : ["29", 8, {"can_stack" : true}],
	"30" : ["30", 8, {"can_stack" : true}],
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

