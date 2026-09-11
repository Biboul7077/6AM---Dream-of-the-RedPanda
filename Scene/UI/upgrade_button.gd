extends Button
class_name UpgradeButton

@onready var label_name: Label = $MarginContainer/VBoxContainer/MarginContainer/LabelName
@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/TextureRect
@onready var label_price: Label = $MarginContainer/VBoxContainer/LabelPrice
@onready var label_description: RichTextLabel = $MarginContainer/VBoxContainer/LabelDescription

@export var upgrade_name: String = ""
@export var upgrade_rarity: Color = Color(255, 180, 50, 1)
@export var upgrade_icon: Texture2D = null
@export var upgrade_price: int = 40
@export var upgrade_description: String = ""

func _process(_delta: float) -> void:
	label_name.text = upgrade_name
	label_name.add_theme_color_override("font_color", upgrade_rarity)
	texture_rect.texture = upgrade_icon
	label_price.text = "Costs %d KeoCoins" % upgrade_price
	label_description.text = upgrade_description
