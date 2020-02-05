defmodule Api.Repo.Migrations.CreateRushing do
  use Ecto.Migration

  def change do
    create table(:rushing) do
      add :player, :string
      add :team, :string
      add :position, :string
      add :attempt_game_average, :float
      add :attempts, :integer
      add :total_yards, :integer
      add :yards_attempt_average, :integer
      add :yards_game, :integer
      add :touchdowns, :integer
      add :longest, :string
      add :first_down, :integer
      add :first_down_percent, :float
      add :twenty_plus_yards, :integer
      add :forty_plus_yards, :integer
      add :fumbles, :integer

      timestamps()
    end
  end
end
