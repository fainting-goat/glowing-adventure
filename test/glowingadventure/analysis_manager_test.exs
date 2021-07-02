defmodule Glowingadventure.AnalysisManagerTest do
  use ExUnit.Case

  alias Glowingadventure.AnalysisManager

  setup do
    AnalysisManager.start_link()
    %{}
  end

  describe "handle_call - save_analysis" do
    test "registers the analysis" do
      assert {:reply, :ok, state} = AnalysisManager.handle_call(
               {:save_analysis, "text", "setting", "frequency"}, nil, []
             )
      assert state == [%{frequencies: "frequency", stop_setting: "setting", text: "text"}]
    end

    test "registers multiple analysis" do
      assert {:reply, :ok, state} = AnalysisManager.handle_call(
               {:save_analysis, "text", "setting", "frequency"}, nil, []
             )
      assert state == [%{frequencies: "frequency", stop_setting: "setting", text: "text"}]

      assert {:reply, :ok, state} = AnalysisManager.handle_call(
               {:save_analysis, "text", "setting", "frequency"}, nil, state
             )
      assert state == [%{frequencies: "frequency", stop_setting: "setting", text: "text"},
               %{frequencies: "frequency", stop_setting: "setting", text: "text"}]
    end
  end

  describe "handle_call - get_analysis" do
    test "returns multiple analysis" do
      fake_state = [%{frequencies: "frequency", stop_setting: "setting", text: "text"},
        %{frequencies: "frequency", stop_setting: "setting", text: "text"}]

      assert {:reply, {:ok, state}, _} = AnalysisManager.handle_call(
               {:get_analysis}, nil, fake_state
             )

      assert state == [%{frequencies: "frequency", stop_setting: "setting", text: "text"},
               %{frequencies: "frequency", stop_setting: "setting", text: "text"}]
    end
  end
end
