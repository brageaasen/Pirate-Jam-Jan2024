extends Node2D

@onready var drill = $Drill
@onready var saw = $Saw


func _input(event : InputEvent):
	if event.is_action_pressed("equip_1"):
		print("equip_1")
		drill.equip()
		saw.un_equip()
	if event.is_action_pressed("equip_2"):
		print("equip_2")
		saw.equip()
		drill.un_equip()
