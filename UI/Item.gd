extends Node2D

var item = ""
var amount = 1

func set_item(item_name):
	$Sprite2D.texture = load("res://UI/item_sheet.png/%s.png" % item_name)
	item = item_name

func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("pick_up"):
		var pl = get_parent().get_parent().get_seeker()
		if abs(pl.position.x - position.x) < 20 and abs(pl.position.y - position.y) < 20:
			get_parent().remove_child(self)
			pl.pick(self)

func get_item():
	return item

func get_amount():
	return amount

