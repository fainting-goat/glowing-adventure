defmodule GlowingadventureWeb.AnalyzeView do
  use GlowingadventureWeb, :view

  def top_twenty_five(results) do
    results
    |> Enum.sort(fn({_, value1}, {_, value2}) -> value1 > value2 end)
    |> Enum.slice(1..25)
  end
end
