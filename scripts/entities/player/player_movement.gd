extends "res://scripts/entities/entity.gd"

@export var speed : float = 80.0

@onready var body = $Body
@onready var animation_tree = $AnimationTree
@onready var character_state_machine = $CharacterStateMachine
@onready var flame_animation = $FlyFlame/FlameAnimation
@onready var main_camera = $MainCamera

var direction : Vector2 = Vector2.ZERO


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	
	if direction.x != 0 && character_state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
	
func update_animation_parameters():
	animation_tree.set("parameters/Move/blend_position", direction.x)
	animation_tree.set("parameters/fly/blend_position", direction.x)
	animation_tree.set("parameters/walk/blend_position", direction.x)

@onready var tool = $Tool

func update_facing_direction():
	if direction.x > 0:
		body.flip_h = false
		flame_animation.flip_h = false
		#tool.flip(false)
	elif direction.x < 0:
		body.flip_h = true
		flame_animation.flip_h = true


func take_damage(damage):
	if not dead:
		# Add screen shake
		main_camera.shake(2)
		health -= damage
		if health <= 0:
			die()




# TODO: Place under Abilities node?

var abilities = []

var loaded_abilities = {}

func load_ability(_name):
	if loaded_abilities.has(_name):
		var scene_instance = loaded_abilities[_name]
		return scene_instance
	else:
		var scene = load("res://scenes/abilities/" + _name + "/" + _name + ".tscn")
		var scene_instance = scene.instantiate()
		call_deferred("add_child", scene_instance)
		loaded_abilities[_name] = scene_instance
		return scene_instance
