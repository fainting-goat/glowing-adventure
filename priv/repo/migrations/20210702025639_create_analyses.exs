defmodule Glowingadventure.Repo.Migrations.CreateAnalyses do
  use Ecto.Migration

  def change do
    create table(:analyses) do
      add :raw_text, :string
      add :stop_exclusion, :boolean, default: false, null: false

      timestamps()
    end

  end
end
