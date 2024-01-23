extends Node

var inventory : Dictionary = { }

func add(item):
	if inventory.has(item):
		inventory[item] += 1
	else:
		inventory[item] = 1
	print(inventory)

func remove(item):
	if inventory.has(item):
		inventory[item] -= 1

func remove_all():
	pass
