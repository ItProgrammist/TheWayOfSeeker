extends Control

@onready var seeker = get_viewport().get_node("Level/Seeker/Seeker")
@onready var pre_inv = preload("res://UI/invent_item.tscn")


func _on_helm_pressed():
	if seeker.gold >= 50:
		seeker.gold -= 50
		var new_item = pre_inv.instantiate()
		new_item.set_item("1", 1, {"can_stack" : true, "function" : "put_on"})
		seeker.pick(new_item)


func _on_red_potion_pressed():
	if seeker.gold >= 15:
		seeker.gold -= 15
		var new_item = pre_inv.instantiate()
		new_item.set_item("135", 1, {"can_stack" : true, "function": "heal", "heal_val": 10, "expandable": true, "exp_rate": 1})
		seeker.pick(new_item)



func _on_armour_pressed():
	if seeker.gold >= 70:
		seeker.gold -= 70
		var new_item = pre_inv.instantiate()
		new_item.set_item("2", 1, {"can_stack" : true, "function" : "put_on"})
		seeker.pick(new_item)


func _on_boot_pressed():
	if seeker.gold >= 40:
		seeker.gold -= 40
		var new_item = pre_inv.instantiate()
		new_item.set_item("4", 1, {"can_stack" : true, "function" : "put_on"})
		seeker.pick(new_item)


func _on_sword_pressed():
	if seeker.gold >= 60:
		seeker.gold -= 60
		var new_item = pre_inv.instantiate()
		new_item.set_item("5", 1, {"can_stack" : true, "function" : "put_on"})
		seeker.pick(new_item)


func _on_blue_potion_pressed():
	if seeker.gold >= 10:
		seeker.gold -= 10
		var new_item = pre_inv.instantiate()
		new_item.set_item("125", 1, {"can_stack" : true, "function": "jump", "expandable": true, "exp_rate": 1})
		seeker.pick(new_item)


func _on_green_potion_pressed():
	if seeker.gold >= 10:
		seeker.gold -= 10
		var new_item = pre_inv.instantiate()
		new_item.set_item("115", 1, {"can_stack" : true, "function": "speed", "expandable": true, "exp_rate": 1})
		seeker.pick(new_item)
