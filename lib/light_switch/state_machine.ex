defmodule LightSwitch.StateMachine do
  @name :LSFSM
  # Client api
  def start_link(initial_state) do
    :gen_fsm.start_link({:local, @name}, __MODULE__, initial_state, [])
  end

  def get_state, do: :gen_fsm.sync_send_event(@name, :get_state)
  def flip_switch_up, do: :gen_fsm.send_event(@name, :flip_switch_up)

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
  Sync call that returns the current state of the state machine
  """
  def on(:get_state, _from, state) do
    {:reply, :on, :on, state}
  end
end
