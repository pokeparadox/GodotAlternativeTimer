extends Node
class_name AlternateTimer
# Editor vars
@export var wait_time : int = 1000
@export var one_shot : bool = false
@export var autostart : bool = false

# Signals
signal timeout()
signal millisecond_elapsed(num_ms : int)
signal second_elapsed(num_s : int)
signal minute_elapsed(num_m : int)
signal hour_elapsed(num_h : int)

# internal
const MILLISECONDS : int = 1000
const MINUTE : int = 60
const HOUR : int = 60
var timer_active : bool = false
var start_ticks : int = 0

var last_ms_ticks : int = 0

#time tracking
var iterations : int = 0
var hours : int = 0
var minutes : int = 0
var seconds : int = 0
var milliseconds : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if autostart:
		start()

func start() -> void:
	timer_active = true
	last_ms_ticks = ticks()
	start_ticks = last_ms_ticks

func stop() -> void:
	timer_active = false

func reset() -> void:
	iterations = 0
	hours = 0
	minutes = 0
	seconds = 0
	milliseconds = 0

func ticks() -> int:
	return Time.get_ticks_msec()
	
# Check for elapsed timeout
func iteration() -> void:
	if ticks() - start_ticks > wait_time:
		iterations += 1
		if one_shot:
			stop()
		else:
			start()
		emit_signal("timeout")

func hour() -> void:
	if minutes > HOUR-1:
		minutes = 0
		hours += 1
		var to_display : int = hours
		if to_display >= HOUR:
			hours = HOUR
			to_display = 0
		emit_signal("hour_elapsed", to_display)

func minute() -> bool:
	if seconds > MINUTE-1:
		seconds = 0
		minutes += 1
		var to_display : int = minutes
		if to_display >= MINUTE:
			minutes = MINUTE
			to_display = 0
		emit_signal("minute_elapsed", to_display)
		return true
	return false
	
func second() -> bool:
	if milliseconds > MILLISECONDS-1:
		milliseconds = 0
		seconds += 1
		var to_display : int = seconds
		if to_display >= MINUTE:
			seconds = MINUTE
			to_display = 0
		emit_signal("second_elapsed", to_display)
		return true
	return false

func millisecond() -> bool:
	var now : int = ticks()
	var increase : int = now - last_ms_ticks
	if increase > 0:
		last_ms_ticks = now
		milliseconds += increase
		emit_signal("millisecond_elapsed", mini(milliseconds, MILLISECONDS - 1))
		return true
	return false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if timer_active:
		iteration()
		if millisecond():
			if second():
				if minute():
					hour()

