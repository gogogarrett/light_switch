defmodule LightSwitch.StateMachine do
  @name :LSFSM

  # Client api
  def start_link(initial_state) when is_number(initial_state) do
    :gen_fsm.start_link({:local, :"light_switch:#{initial_state}"}, __MODULE__, [], [])
  end
  def start_link(initial_state) when is_list(initial_state) do
    :gen_fsm.start_link({:local, @name}, __MODULE__, initial_state, [])
  end

  def get_state(pid \\ @name) do
    :gen_fsm.sync_send_event(pid, :get_state)
  end

  def flip_switch_up(pid \\ @name) do
    :gen_fsm.send_event(pid, :flip_switch_up)
  end

  def flip_switch_down(pid \\ @name) do
    :gen_fsm.send_event(pid, :flip_switch_down)
  end

  # GenFSM api
  def init(state) do
    {:ok, :off, state}
  end

  @doc """
  Sync call that returns the current state of the state machine
  """
  def off(:get_state, _from, state) do
    {:reply, :off, :off, state}
  end

  @doc """
  Async event that flips the switch up.. which as a result changes the state to `on`
  """
  def off(:flip_switch_up, state) do
    {:next_state, :on, state}
  end

  @doc """
  Async event that flips the switch down..
  which as a result does nothing because we're already off, silly goose.
  """
  def off(:flip_switch_down, state) do
    {:next_state, :off, state}
  end

  @doc """
  Sync call that returns the current state of the state machine
  """
  def on(:get_state, _from, state) do
    {:reply, :on, :on, state}
  end

  @doc """
  Async event that flips the switch down.. which as a result changes the state to `off`
  """
  def on(:flip_switch_down, state) do
    {:next_state, :off, state}
  end

  @doc """
  Async event that flips the switch up..
  which as a result does nothing because we're already on, silly goose.
  """
  def on(:flip_switch_up, state) do
    {:next_state, :on, state}
  end
end
