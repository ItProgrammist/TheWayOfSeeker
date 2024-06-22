extends Node2D

var item = ""
var amount = 1
var stack_limit = 8
var properties = {}
@onready var pre_inv = preload("res://UI/invent_item.tscn")


func set_item(props):
	$Sprite2D.texture = load("res://UI/item_sheet.png/%s.png" % props[0])
	item = props[0]
	stack_limit = props[1]
	self.properties = props[2]

func _ready():
	pass # Replace with function body.

func set_amount(am):
	amount = am

func _input(event):
	if event.is_action_pressed("pick_up"):
		var pl = get_parent().get_parent().get_seeker()
		if abs(pl.position.x - position.x) < 20 and abs(pl.position.y - position.y) < 20:
			var new_item = pre_inv.instantiate()
			new_item.set_item(item, amount, properties)
			var is_picked = pl.pick(new_item)
			
			if is_picked:
				get_parent().remove_child(self)
				queue_free()
			else:
				new_item.queue_free()

func get_item():
	return item

func get_amount():
	return amount

func get_item_stack():
	return stack_limit

