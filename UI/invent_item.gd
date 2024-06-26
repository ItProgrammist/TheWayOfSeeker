extends Control

var item_name = ""
var item_amount = 0
var properties = {}
var inventory = null

@onready var inventory_owner = null
@onready var helm = get_viewport().get_node("Level/CanvasLayer2/Armor/VBoxContainer/helm")
@onready var armour = get_viewport().get_node("Level/CanvasLayer2/Armor/VBoxContainer/armour")
@onready var boot = get_viewport().get_node("Level/CanvasLayer2/Armor/VBoxContainer/boot")
@onready var weapon = get_viewport().get_node("Level/CanvasLayer2/Armor/VBoxContainer/weapon")

func set_item(item_name, amount, props):
	self.item_name = item_name
	self.item_amount = amount
	self.properties = props.duplicate()
	$ColorRect.visible = false
	$TextureRect.texture = load("res://UI/item_sheet.png/%s.png" % item_name)
	$Amount.text = str(amount)

func get_item_name():
	return item_name

func add_amount(am):
	item_amount += am
	$Amount.text = str(item_amount)

func get_amount():
	return item_amount

func set_amount(val):
	item_amount = val
	
func get_props():
	return properties

func set_inventory(val):
	inventory = val

func set_invent_owner(own):
	inventory_owner = own

func remove_amount(am):
	item_amount -= am
	$Amount.text = str(item_amount)
	if item_amount == 0:
		inventory.remove_item(self)

func can_stack():
	return properties["can_stack"]

func save():
	return [item_name, item_amount, properties]

func _on_button_pressed():
	$ColorRect.visible = !$ColorRect.visible

func _on_drop_pressed():
	inventory.get_inv_owner().drop_item(self)
	if item_name == "1":
		helm.texture = load("res://CraftpixPacks/Kasaya's Frames/Inventory & chests/2/helm.png")
		Global.helm_load = false
						
	if item_name == "2":
		armour.texture = load("res://CraftpixPacks/Kasaya's Frames/Inventory & chests/2/armour.png")
		Global.armour_load = false
						
	if item_name == "4":
		boot.texture = load("res://CraftpixPacks/Kasaya's Frames/Inventory & chests/2/boot.png")
		Global.boot_load = false
						
	if item_name == "5" or item_name == "7":
		weapon.texture = load("res://CraftpixPacks/Kasaya's Frames/Inventory & chests/2/brown slot.png")
		Global.weapon_load = false


func _on_use_pressed():
	var target = inventory.get_inv_owner()
	if "function" in properties.keys():
		match properties["function"]:
			"heal":
				target.increase_hp(properties["heal_val"])
				if properties["expandable"]:
					remove_amount(properties["exp_rate"])
			"put_on":
				if item_name == "1":
					if Global.helm_load == false:
						helm.texture = load("res://UI/item_sheet.png/1.png")
						Global.helm_load = true
					else:
						helm.texture = load("res://CraftpixPacks/Kasaya's Frames/Inventory & chests/2/helm.png")
						Global.helm_load = false
						
				if item_name == "2":
					if Global.armour_load == false:
						armour.texture = load("res://UI/item_sheet.png/2.png")
						Global.armour_load = true
					else:
						armour.texture = load("res://CraftpixPacks/Kasaya's Frames/Inventory & chests/2/armour.png")
						Global.armour_load = false
						
				if item_name == "4":
					if Global.boot_load == false:
						boot.texture = load("res://UI/item_sheet.png/4.png")
						Global.boot_load = true
					else:
						boot.texture = load("res://CraftpixPacks/Kasaya's Frames/Inventory & chests/2/boot.png")
						Global.boot_load = false
						
				if item_name == "5" or item_name == "7":
					if Global.weapon_load == false:
						weapon.texture = load("res://UI/item_sheet.png/%s.png" % item_name)
						Global.weapon_load = true
					else:
						weapon.texture = load("res://CraftpixPacks/Kasaya's Frames/Inventory & chests/2/brown slot.png")
						Global.weapon_load = false
						
			"speed":
				target.increase_speed()
				if properties["expandable"]:
					remove_amount(properties["exp_rate"])
			"jump":
				target.increase_jump()
				if properties["expandable"]:
					remove_amount(properties["exp_rate"])
