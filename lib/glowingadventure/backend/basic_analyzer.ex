defmodule Glowingadventure.BasicAnalyzer do

  @impl Glowingadventure.Analyzer
  def analyze_text(text) do
    text
    |> String.split(~r{\n| })
    |> Enum.reduce(%{}, fn x, acc ->
      case acc[x] do
        nil ->
          Map.put(acc, x,  1)
        count ->
          %{acc | x => count + 1}
      end
    end)
  end
end
