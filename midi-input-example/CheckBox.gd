extends CheckBox



func _on_CheckBox_toggled(_button_pressed):
	$"../RichTextLabel".scroll_following = !$"../RichTextLabel".scroll_following
