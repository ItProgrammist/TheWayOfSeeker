extends PanelContainer

@onready var item = preload("res://UI/invent_item.tscn")
@onready var container = $GridContainer

func _ready():
	clear()
	visible = false

func clear():
	for i in container.get_children():
		container.remove_child(i)
		i.queue_free()

func show_inventory(inventory):
	clear()
	for i in inventory.keys():
		var new_item = item.instantiate()
		container.add_child(new_item)
		new_item.set_item(i, inventory[i])
