extends Node

enum ACTIONS {ATTACK, SPECIAl, ITEMS, RUN}

# Basic Battle actions. The idea is that different entities might have different base attacks, like Yui might have "Bite" that damages a single enemy, Snowflake might have "Scratch" that damages multiple at once, but has a lower damage rate, etc. 
# Should probably be based on animal type, not random. 
func bite(current: Battle_Entity, target: Battle_Entity) -> void:
	target.health -= int(pow(1.5, current.level))

func scratch() -> void:
	#TODO
	pass