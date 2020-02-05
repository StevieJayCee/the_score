defmodule ApiWeb.RushingView do
  use ApiWeb, :view
  alias ApiWeb.RushingView

  def render("index.json", %{rushing: rushing}) do
    %{data: render_many(rushing, RushingView, "rushing.json")}
  end

  def render("show.json", %{rushing: rushing}) do
    %{data: render_one(rushing, RushingView, "rushing.json")}
  end

  def render("rushing.json", %{rushing: rushing}) do
    %{
      id: rushing.id,
      player: rushing.player,
      team: rushing.team,
      position: rushing.position,
      attempt_game_average: rushing.attempt_game_average,
      attempts: rushing.attempts,
      total_yards: rushing.total_yards,
      yards_attempt_average: rushing.yards_attempt_average,
      yards_game: rushing.yards_game,
      touchdowns: rushing.touchdowns,
      longest: rushing.longest,
      first_down: rushing.first_down,
      first_down_percent: rushing.first_down_percent,
      twenty_plus_yards: rushing.twenty_plus_yards,
      forty_plus_yards: rushing.forty_plus_yards,
      fumbles: rushing.fumbles
    }
  end
end
