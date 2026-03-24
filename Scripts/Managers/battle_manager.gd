extends Node

var player_turn_finished: bool
var enemy_turn_finished: bool

enum BATTLE_STATES {
	PLAYER_TURN,
	ENEMY_TURN,
	WIN,
	DEFEAT
}

var state: BATTLE_STATES
func _ready() -> void:
	state = BATTLE_STATES.PLAYER_TURN
	player_turn_finished = false
	enemy_turn_finished = false

func _process(_delta: float) -> void:
	update_battle()


func update_battle() -> void:
	match state:
		BATTLE_STATES.PLAYER_TURN:
			# Wait for player input, and depending on action selected in menu, execute some action. For now, this will just print the state for testing purposes
			print("State is player turn!")
			if Input.is_action_just_pressed("ui_accept"):
				state = BATTLE_STATES.ENEMY_TURN
			pass
		BATTLE_STATES.ENEMY_TURN:
			print("State is Enemy turn!")
			if Input.is_action_just_pressed("ui_accept"):
				state = BATTLE_STATES.PLAYER_TURN
			pass
			pass
		BATTLE_STATES.WIN:
			pass
		BATTLE_STATES.DEFEAT: 
			pass	
		_:
			pass
	pass