@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("AlternateTimer", "Node", load("res://addons/alternatetimer/AlternateTimer.gd"), load("res://addons/alternatetimer/Timer.svg"))

func _exit_tree():
	remove_custom_type("AlternateTimer")
