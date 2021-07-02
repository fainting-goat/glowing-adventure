defmodule Glowingadventure.AnalysisManager do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: :saved_analysis)
  end

  def init(state) do
    state = load_state_from_database()
    Process.flag(:trap_exit, true)
    {:ok, state}
  end

  def handle_info({:EXIT, _from, reason}, state) do
    save_state(state)
    {:stop, reason, state}
  end

  def terminate(_reason, state) do
    save_state(state)
    state
  end

  def load_state_from_database() do
    # TODO: read from database
    []
  end

  # TODO: there's a problem here in that we aren't recording which analysis was used to build this
  # we'll either need to pass that in and save it or save the analysis itself
  # otherwise we won't be able to restore/recreate the analysis
  def save_state(state) do
    Enum.each(state, fn(%{text: text, stop_setting: stop_setting}) ->
      Glowingadventure.Analyses.create_analysis(%{raw_text: text, stop_setting: stop_setting})
    end)
    :ok
  end

  #API

  def save_analysis(text, stop_setting, frequencies) do
    GenServer.call(:saved_analysis, {:save_analysis, text, stop_setting, frequencies})
  end

  def get_analysis() do
    GenServer.call(:saved_analysis, {:get_analysis})
  end

  #CALLBACKS

  def handle_call({:save_analysis, text, stop_setting, frequencies}, _from, state) do

    new_state = add_to_map(state, %{text: text, stop_setting: stop_setting, frequencies: frequencies})
    {:reply, :ok, new_state}
  end

  def handle_call({:get_analysis}, _from, state) do
    {:reply, {:ok, state}, state}
  end

  defp add_to_map(acc, new) when length(acc) > 10 do
    {_, acc} = List.pop_at(acc, 9)
    add_to_map(acc, new)
  end
  defp add_to_map(acc, new) do
    [ new | acc]
  end
end
