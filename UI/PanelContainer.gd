extends NinePatchRect

@onready var item = preload("res://UI/invent_item.tscn")

@onready var container = $GridContainer
@onready var inventory_owner = null

func _ready():
	clear()
	visible = false


func clear():
	for i in container.get_children():
		container.remove_child(i)

func show_inventory(inventory):
	clear()
	#inventory_owner = inventory.get_inv_owner()
	for i in inventory.get_items():
		#i.set_invent_owner(inventory_owner)
		container.add_child(i)
