# LightSwitch

A simple application to demonstrate how to use the [erlang gen_fsm](http://erlang.org/doc/man/gen_fsm.html) in an elixir project.

# Usage
```
iex(1)> LightSwitch.StateMachine.get_state
:off
iex(2)> LightSwitch.StateMachine.flip_switch_up
:ok
iex(3)> LightSwitch.StateMachine.get_state
:on
iex(4)> LightSwitch.StateMachine.flip_switch_down
:ok
iex(5)> LightSwitch.StateMachine.get_state
:off
```

## Things of note

- [`sync_send_event`](http://erlang.org/doc/man/gen_fsm.html#sync_send_event-2) is SYNC and similar to [`call`](http://elixir-lang.org/docs/v1.0/elixir/GenServer.html#call/3) in GenServers.
- [`send_event`](http://erlang.org/doc/man/gen_fsm.html#send_event-2) is ASYNC and similar to [`cast`](http://elixir-lang.org/docs/v1.0/elixir/GenServer.html#cast/2) in GenServers.
