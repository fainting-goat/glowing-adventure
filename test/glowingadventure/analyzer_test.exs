defmodule Glowingadventure.AnalyzerTest do
  use Glowingadventure.DataCase, async: false

  alias Glowingadventure.Analyzer

  setup do
   %{text: "one two two three three three"}
  end

    describe "analyze_text/1" do
    test "parses correctly", %{text: text} do
      results = %{"one" => 1, "two" => 2, "three" => 3}
      assert ^results = Analyzer.analyze_text(text)
    end
  end
end
