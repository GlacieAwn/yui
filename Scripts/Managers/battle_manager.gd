extends Node

enum BATTLE_STATES {
	PLAYER_TURN,
	ENEMY_TURN,
	WIN,
	DEFEAT
}

var state: BATTLE_STATES
func _ready() -> void:
	pass

func update_battle() -> void:
	match state:
		BATTLE_STATES.PLAYER_TURN:
			pass
		BATTLE_STATES.ENEMY_TURN:
			pass
		BATTLE_STATES.WIN:
			pass
		BATTLE_STATES.DEFEAT: 
			pass	
		_:
			pass
	pass