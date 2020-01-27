extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$message.text = ""
	$gamers.text = ""
	$startButton.hide()
	NetManager.connect("connection_failed", self, "_on_connection_failed")
	NetManager.connect("connection_succeeded", self, "_on_connection_success")
#	NetManager.connect("player_list_changed", self, "refresh_lobby")
	NetManager.connect("game_ended", self, "_on_game_ended")
	NetManager.connect("game_error", self, "_on_game_error")

func _on_JoinButton_pressed():
	$message.text = "conockt'ing"
	var ip: String = $IPEdit.text
	var port: int = int($PortEdit.text)
	var name: String = $NameEdit.text
	var kart: int = $CarSelect.selected
	NetManager.join_game(ip, port, name, kart)
	$startButton.hide()

func _on_startButton_pressed():
	var track: int = $TrackSelect.selected
	NetManager.begin_game(track)

func _on_HostButton_pressed():
	$message.text = "ho'sting"
	var port: int = int($PortEdit.text)
	var playerName: String = $NameEdit.text
	var kart: int = $CarSelect.selected
	NetManager.host_game(playerName, kart, port)
	$startButton.show()

func _on_connection_failed():
	$message.text = $message.text + "\nconnection fial'd!"

func _on_connection_success():
	$message.text = $message.text + "\nkonnoc't'd!"

func player_connected():
	var oldtext = $message.text
	$message.text = oldtext + "\n" + "Player conok't!"

func game_error():
	var oldtext = $message.text
	$message.text = oldtext + "\n" + "KABOOM!"

func _process(delta):
	var players = NetManager.get_player_list()
	players.sort()
	$gamers.text = ""
	for p in players:
		$gamers.text += "\n" + p
	$gamers.text += "\n" + $NameEdit.text + " (You)"
