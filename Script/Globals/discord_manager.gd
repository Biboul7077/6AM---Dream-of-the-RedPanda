extends Node

var presence: DiscordRichPresence

func _ready() -> void:
	presence = DiscordRichPresence.new()
	presence.app_id = "1542263996265009312"
	add_child(presence)

	presence.presence_connected.connect(_on_presence_connected)
	presence.presence_disconnected.connect(_on_presence_disconnected)

	_update_activity("Dans le menu principal")

func _on_presence_connected(user: Dictionary) -> void:
	print("Discord RPC connecté : ", user)

func _on_presence_disconnected() -> void:
	print("Discord RPC déconnecté, tentative de reconnexion...")

func _update_activity(state_text: String, details_text: String = "6AM - Dream of the RedPanda") -> void:
	if presence == null:
		return
	presence.set_activity({
		"details": details_text,
		"state": state_text,
		"timestamps": {"start": int(Time.get_unix_time_from_system())},
		"assets": {"large_image": "your_art_asset_key"},
	})
