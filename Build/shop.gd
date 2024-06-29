extends Area2D

@onready var shop = get_viewport().get_node("Level/Shop2")

func _on_button_pressed():
	shop.visible = !shop.visible
	
