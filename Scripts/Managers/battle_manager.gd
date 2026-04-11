extends Node

var player_turn_finished: bool
var enemy_turn_finished: bool

# Test vars
var player_health
var player_level
var current_enemy_health

enum BATTLE_STATES { BEGIN, PLAYER_TURN, ENEMY_TURN, WIN, DEFEAT, RESOLUTION }

var state: BATTLE_STATES
func _ready() -> void:
	state = BATTLE_STATES.PLAYER_TURN
	player_turn_finished = false
	enemy_turn_finished = false

	player_health = 5
	player_level = 1
	current_enemy_health = 4

func _process(_delta: float) -> void:
	update_battle()


func update_battle() -> void:
	match state:
		BATTLE_STATES.PLAYER_TURN:
			# Wait for player input, and depending on action selected in menu, execute some action. For now, this will just print the state for testing purposes
			print("State is player turn!")
			print("Player Health is: %i", player_health)
			if Input.is_action_just_pressed("ui_accept"):
				
				state = BATTLE_STATES.ENEMY_TURN
		BATTLE_STATES.ENEMY_TURN:
			if not current_enemy_health <= 0:
				print("State is Enemy turn!")
				print("Enemy Health is: %i", current_enemy_health)
				if Input.is_action_just_pressed("ui_accept"):
					current_enemy_health -= int(pow(1.5, player_level))
					state = BATTLE_STATES.PLAYER_TURN
			else:
				state = BATTLE_STATES.WIN
		BATTLE_STATES.WIN:
			print("Enemy Defeated!")
			pass
		BATTLE_STATES.DEFEAT: 
			pass
		BATTLE_STATES.RESOLUTION:
			pass	
		_:
			pass
	pass
