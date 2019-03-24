extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.open_midi_inputs()

	print(OS.get_connected_midi_inputs())

	for current_midi_input in OS.get_connected_midi_inputs():
		print(current_midi_input)
