extends Node

var inventory : Dictionary = { }

@onready var main_camera = $"../MainCamera"

func add(item):
	if inventory.has(item):
		inventory[item] += 1
	else:
		inventory[item] = 1
	main_camera.change_light_scale(main_camera.zoom.x - 1)

func remove(item):
	if inventory.has(item):
		inventory[item] -= 1

func remove_all():
	pass
