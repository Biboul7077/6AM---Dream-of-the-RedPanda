extends Control

@export var action_name: String
@export var action_id: String
@onready var rebind_button: RebindButton = $HBoxContainer/RebindButton
@onready var label: Label = $HBoxContainer/Label

func _ready() -> void:
	label.text = action_name
	rebind_button.action = action_id
	rebind_button._toggled(false)
