extends TextureRect

func set_item(item_name, amount):
	texture = load("res://UI/item_sheet.png/%s.png" % item_name)
	$Amount.text = str(amount)
