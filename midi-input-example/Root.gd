extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.open_midi_inputs()

	print(OS.get_connected_midi_inputs())

