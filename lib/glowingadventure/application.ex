defmodule Glowingadventure.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      # Start the Ecto repository
      Glowingadventure.Repo,
      # Start the Telemetry supervisor
      GlowingadventureWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Glowingadventure.PubSub},
      # Start the Endpoint (http/https)
      GlowingadventureWeb.Endpoint,
      worker(Glowingadventure.AnalysisManager, [])
      # Start a worker by calling: Glowingadventure.Worker.start_link(arg)
      # {Glowingadventure.Worker, arg}

    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Glowingadventure.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GlowingadventureWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
