defmodule GlowingadventureWeb.PageController do
  use GlowingadventureWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  # just a utility feature so I can be lazy and make sure the database/genserver is saving correctly
  def debug(conn, _params) do
    IO.inspect Glowingadventure.AnalysisManager.get_analysis()
    IO.inspect Glowingadventure.Analyses.list_analyses()
    conn
    |> redirect(to: "/")
  end
end
