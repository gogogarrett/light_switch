defmodule LightSwitch.StateMachineTest do
  use ExUnit.Case

  setup do
    on_exit fn ->
      # Ensure we're always in "off" state at the beginning of test
      if LightSwitch.StateMachine.get_state == :on do
        LightSwitch.StateMachine.flip_switch_down
      end
    end
  end

  test "starts up" do
    pid = Process.whereis(:LSFSM)
    assert Process.alive?(pid) == true
  end

  test "get_state" do
    assert LightSwitch.StateMachine.get_state == :off
  end

  test "flip_switch_up switches light on!" do
    LightSwitch.StateMachine.flip_switch_up
    assert LightSwitch.StateMachine.get_state == :on
  end

  test "flip_switch_down switches light off" do
    LightSwitch.StateMachine.flip_switch_up
    assert LightSwitch.StateMachine.get_state == :on

    LightSwitch.StateMachine.flip_switch_down
    assert LightSwitch.StateMachine.get_state == :off
  end
end
