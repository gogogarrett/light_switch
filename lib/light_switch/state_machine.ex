defmodule LightSwitch.StateMachine do
  @name :LSFSM
  # Client api
  def start_link(initial_state) do
    :gen_fsm.start_link({:local, @name}, __MODULE__, initial_state, [])
  end

  def get_state, do: :gen_fsm.sync_send_event(@name, :get_state)

  # GenFSM api
  def init(state) do
    {:ok, :off, state}
  end

  def off(:get_state, _from, state) do
    {:reply, :off, :off, state}
  end
end
