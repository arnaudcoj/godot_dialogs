
extends StaticBody2D

var dialog_speech_gd = preload("res://scripts/dialog_speech.gd")
var dialog_change_state_gd = preload("res://scripts/dialog_change_state.gd")

var dialog_node
var character_currently_talking

func _ready():
	get_node("entities/player").set_camera_limit(get_node("camera_limit").get_rect())
	get_node("entities/player").connect("interact", self, "on_interact")

func on_interact(target = "npc1"):
	print("interacting with ", target)
	if dialog_node == null:
		dialog_node = dialogs.get_dialog(get_name(), target)
		character_currently_talking = null
	
	
	var blocking = false
	while dialog_node != null && not blocking :
		if dialog_node extends dialog_speech_gd:character_currently_talking
			var character = dialog_node.character
			var dialog = dialog_node.dialog
			print(character + " says " + dialog)
			get_node("entities/" + character).speech.set_text(dialog)
			
			if character_currently_talking != character:
				if character_currently_talking != null:
					print(character_currently_talking + " stops talking")
					get_node("entities/" + character_currently_talking).speech.deactivate()
				print(character + " starts talking")
				get_node("entities/" + character).speech.activate()
			character_currently_talking = character
		elif dialog_node extends dialog_change_state_gd:
			for character_state in dialog_node.characters_states:
				var character = character_state[0]
				var state = character_state[1]
				print(character + " is now " + str(state))
				get_node("entities/" + character).change_state(state)
		blocking = dialog_node.blocking
		dialog_node = dialog_node.next
	
#		if dialog_node extends dialog_change_state_gd :
#			for character_state in dialog_node.characters_states:
#				var character = character_state[0]
#				var state = character_state[1]
#				get_node("entities/" + character).change_state(state)
#		elif dialog_node extends dialog_node_gd :
#			var speaker = dialog_node.character
#			get_node("entities/" + speaker).speech.set_text(dialog_node.dialog)
#			dialog_node = dialog_node.next
#		else:
#			dialog_node = null