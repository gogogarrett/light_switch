defmodule LightSwitch.HomeStateMachine do
  use Supervisor

  @registered_name HomeStateMachine

  @total_number_of_lights 10
  @all_lights 1..@total_number_of_lights

  # client
  def start_link([]) do
    Supervisor.start_link(__MODULE__, [], [name: @registered_name])
  end

  @doc """
  Loops through every light we have setup - fetches the PID for that light
  and switches the switch up!
  """
  def turn_all_lights(:on) do
    for light <- @all_lights, do: light_pid(light) |> LightSwitch.StateMachine.flip_switch_up
  end

  @doc """
  Loops through every light we have setup - fetches the PID for that light
  and switches the switch off!
  """
  def turn_all_lights(:off) do
    for light <- @all_lights, do: light_pid(light) |> LightSwitch.StateMachine.flip_switch_down
  end

  @doc """
  Loops through every light we have setup - fetches the PID for that light
  Returns the current state for each light we have running
  """
  def get_all_light_states do
    for light <- @all_lights, do: light_pid(light) |> LightSwitch.StateMachine.get_state
  end

  @doc """
  Randomly selects half of the lights - fetches the PID for that light
  and switches the switch up
  """
  def turn_some_lights(:on) do
    for light <- random_lights, do: light_pid(light) |> LightSwitch.StateMachine.flip_switch_up
  end

  @doc """
  Randomly selects half of the lights - fetches the PID for that light
  and switches the switch off
  """
  def turn_some_lights(:off) do
    for light <- random_lights, do: light_pid(light) |> LightSwitch.StateMachine.flip_switch_down
  end

  # server
  def init([]) do
    children = for light <- @all_lights do
      worker(LightSwitch.StateMachine, [light], id: light)
    end
    supervise(children, strategy: :one_for_one)
  end


  defp light_pid(number), do: Process.whereis(:"light_switch:#{number}")
  defp random_lights do
    Enum.take_random(@all_lights, div(@total_number_of_lights, 2))
  end
end
