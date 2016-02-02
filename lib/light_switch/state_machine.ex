defmodule LightSwitch.StateMachine do
  @name :LSFSM
  # Client api
  def start_link(initial_state) do
    :gen_fsm.start_link({:local, @name}, __MODULE__, initial_state, [])
  end

  # GenFSM api
  def init(state) do
    {:ok, :off, state}
  end
end
