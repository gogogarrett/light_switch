defmodule LightSwitch.HomeStateMachineTest do
  use ExUnit.Case

  alias LightSwitch.HomeStateMachine

  test "switches all lights on!" do
    HomeStateMachine.turn_all_lights(:on)

    assert HomeStateMachine.get_all_light_states == on_list
  end

  test "switches all lights off!" do
    HomeStateMachine.turn_all_lights(:on)
    assert HomeStateMachine.get_all_light_states == on_list
    HomeStateMachine.turn_all_lights(:off)
    assert HomeStateMachine.get_all_light_states == off_list
  end

  test "turns ON 1/2 of the lights" do
    # 10 total lights, turn on 1/2
    HomeStateMachine.turn_some_lights(:on)

    # count the `on` ones
    on_count = HomeStateMachine.get_all_light_states |> Enum.count(&(&1 == :on))

    # ensure 1/2 of the lights are on
    assert on_count == 5
  end

  test "turns OFF 1/2 of the lights" do
    # 10 total lights, turn on 1/2
    HomeStateMachine.turn_all_lights(:on)

    HomeStateMachine.turn_some_lights(:off)

    # count the `off` ones
    off_count = HomeStateMachine.get_all_light_states |> Enum.count(&(&1 == :off))

    # ensure 1/2 of the lights are on
    assert off_count == 5
  end

  defp on_list, do: for _x <- 1..10, do: :on
  defp off_list, do: for _x <- 1..10, do: :off
end
