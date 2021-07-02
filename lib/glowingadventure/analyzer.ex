defmodule Glowingadventure.Analyzer do

  @temp_text "Lorem ipsum dolor sit amet and Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

  @callback analyze_text(String.t()) :: :ok

  def analyze_text(text \\ @temp_text) do
    backend().analyze_text(text)
  end

  defp backend do
    # TODO: make this configurable
    Glowingadventure.BasicAnalyzer
  end
end
