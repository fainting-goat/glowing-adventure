defmodule Glowingadventure.Repo do
  use Ecto.Repo,
    otp_app: :glowingadventure,
    adapter: Ecto.Adapters.Postgres
end
