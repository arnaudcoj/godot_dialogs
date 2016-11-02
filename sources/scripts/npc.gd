
extends KinematicBody2D

export var walking_speed = 3

onready var state = IdleState.new(self)
onready var animation = get_node("animation")

onready var speech = get_node("speech")

var dialog_node

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	
func _fixed_process(delta):
	state.process(delta)
	
func _input(event):
	state.input(event)
	
func set_camera_limit(rect):
	var camera = get_node("camera")
	camera.set_limit(MARGIN_LEFT, rect.pos.x)
	camera.set_limit(MARGIN_TOP, rect.pos.y)
	camera.set_limit(MARGIN_RIGHT, rect.pos.x + rect.size.x)
	camera.set_limit(MARGIN_BOTTOM, rect.pos.y + rect.size.y)

func change_state(state_enum):
	state.exit()
	
	if state_enum == states_enum.IDLE_STATE:
		state = IdleState.new(self)
	elif state_enum == states_enum.WALKING_STATE:
		state = WalkingState.new(self)
	elif state_enum == states_enum.INTERACT_STATE:
		state = InteractState.new(self)
	elif state_enum == states_enum.TALKING_STATE:
		state = TalkingState.new(self)

func is_move_action_pressed():
	return Input.is_action_pressed("ui_up") or  Input.is_action_pressed("ui_down") or  Input.is_action_pressed("ui_left") or  Input.is_action_pressed("ui_right")

func get_moving_direction():
	var direction = Vector2(0,0)
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	return direction.normalized()

#STATES

class IdleState:
	var player
	
	func _init(player):
		self.player = player
		if player.get_node("animation").get_current_animation() != "idle":
			player.get_node("animation").play("idle")
		print("idle")
		
	func process(delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		pass
		
class WalkingState:
	var player
	
	func _init(player):
		self.player = player
		player.get_node("animation").play("walking")
		print("walking")
		
	func process(delta):
		var direction = Vector2(0,0)
		if direction.x == 0 and direction.y == 0:
			player.change_state(states_enum.IDLE_STATE)
		else:
			player.move(direction)
	
	func input(event):
		pass
	
	func exit():
		pass

class InteractState:
	var player
	
	func _init(player):
		self.player = player
		if player.get_node("animation").get_current_animation() != "idle":
			player.get_node("animation").play("idle")
		print("interact")
		
	func process(delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		player.speech.deactivate()
		
class TalkingState:
	var player
	
	func _init(player):
		self.player = player
		if player.get_node("animation").get_current_animation() != "talking":
			player.get_node("animation").play("talking")
		print("talking")
		
	func process(delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		player.speech.deactivate()
