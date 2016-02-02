defmodule LightSwitch.StateMachineTest do
  use ExUnit.Case

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
end
