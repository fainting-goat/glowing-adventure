defmodule GlowingadventureWeb.AnalyzeController do
  use GlowingadventureWeb, :controller

  # TODO: we could put most of this into a with and then handle any errors using the fallback controller
  def analyze(conn, %{"file" => upload}) do
    {:ok, text} = File.read(upload.path)

    analysis = Glowingadventure.Analyzer.analyze_text(text)

    :ok = Glowingadventure.AnalysisManager.save_analysis(text, "TODO", analysis)

    conn
    |> put_flash(:info, "Analysis completed.")
    |> render("analyze.html", results: analysis, error: false)
  end
end
