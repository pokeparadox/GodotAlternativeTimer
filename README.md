# AlternativeTimer
This is an alternative Timer addon for Godot 4.1

It could easily be expanded further if needed but this suits my current needs.


## Editor Values
- @export var wait_time : int = 1000
- @export var one_shot : bool = false
- @export var autostart : bool = false

## Signals
- signal timeout()
- signal millisecond_elapsed(num_ms : int)
- signal second_elapsed(num_s : int)
- signal minute_elapsed(num_m : int)
- signal hour_elapsed(num_h : int)

## Methods
- start()
- stop()
- reset()
