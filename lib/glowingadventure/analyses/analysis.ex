defmodule Glowingadventure.Analyses.Analysis do
  use Ecto.Schema
  import Ecto.Changeset

  schema "analyses" do
    field :raw_text, :string
    field :stop_exclusion, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(analysis, attrs) do
    analysis
    |> cast(attrs, [:raw_text, :stop_exclusion])
    |> validate_required([:raw_text, :stop_exclusion])
  end
end
