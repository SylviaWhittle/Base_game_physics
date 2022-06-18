extends Node2D

enum LOGGING_STATE {
	INFO = 3,
	WARNING = 2,
	CRITICAL = 1,
	FATAL = 0
}

export var logging_state = LOGGING_STATE.INFO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 

func info(caller, message):
	if logging_state >= LOGGING_STATE.INFO:
		printlog(caller, message)

func warning(caller, message):
	if logging_state >= LOGGING_STATE.WARNING:
		printlog(caller, message)

func critical(caller, message):
	if logging_state >= LOGGING_STATE.CRITICAL:
		printlog(caller, message)

func fatal(caller, message):
	if logging_state >= LOGGING_STATE.FATAL:
		printlog(caller, message)

func printlog(caller, message):
	var log_state_string = null
	if logging_state == LOGGING_STATE.INFO: log_state_string = 'INFO'
	if logging_state == LOGGING_STATE.WARNING: log_state_string = 'WARNING'
	if logging_state == LOGGING_STATE.CRITICAL: log_state_string = 'CRITICAL'
	if logging_state == LOGGING_STATE.FATAL: log_state_string = 'FATAL'
	print(str(log_state_string) + ' > ' + str(caller.name) + ': ' + str(message))
