extends Control

@onready var seeker = get_viewport().get_node("Level/Seeker/Seeker")
@onready var pre_inv = preload("res://UI/invent_item.tscn")


func _on_helm_pressed():
	if Global.gold >= 500:
		Global.gold -= 500
		var new_item = pre_inv.instantiate()
		new_item.set_item("1", 1, {"can_stack" : true, "function" : "put_on"})
		seeker.pick(new_item)


func _on_red_potion_pressed():
	if Global.gold >= 150:
		Global.gold -= 150
		var new_item = pre_inv.instantiate()
		new_item.set_item("135", 1, {"can_stack" : true, "function": "heal", "heal_val": 10, "expandable": true, "exp_rate": 1})
		seeker.pick(new_item)



func _on_armour_pressed():
	if Global.gold >= 700:
		Global.gold -= 700
		var new_item = pre_inv.instantiate()
		new_item.set_item("2", 1, {"can_stack" : true, "function" : "put_on"})
		seeker.pick(new_item)


func _on_boot_pressed():
	if Global.gold >= 400:
		Global.gold -= 400
		var new_item = pre_inv.instantiate()
		new_item.set_item("4", 1, {"can_stack" : true, "function" : "put_on"})
		seeker.pick(new_item)


func _on_sword_pressed():
	if Global.gold >= 600:
		Global.gold -= 600
		var new_item = pre_inv.instantiate()
		new_item.set_item("5", 1, {"can_stack" : true, "function" : "put_on"})
		seeker.pick(new_item)


func _on_blue_potion_pressed():
	if Global.gold >= 100:
		Global.gold -= 100
		var new_item = pre_inv.instantiate()
		new_item.set_item("125", 1, {"can_stack" : true, "function": "jump", "expandable": true, "exp_rate": 1})
		seeker.pick(new_item)


func _on_green_potion_pressed():
	if Global.gold >= 100:
		Global.gold -= 100
		var new_item = pre_inv.instantiate()
		new_item.set_item("115", 1, {"can_stack" : true, "function": "speed", "expandable": true, "exp_rate": 1})
		seeker.pick(new_item)
