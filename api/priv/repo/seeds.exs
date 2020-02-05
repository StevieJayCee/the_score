# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Api.Repo.insert!(%Api.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Api.Statistics.Rushing
alias Api.Repo

%Rushing{
  attempt_game_average: 2.3,
  attempts: 3,
  first_down: 2,
  first_down_percent: 22.5,
  forty_plus_yards: 5,
  fumbles: 1,
  longest: "12",
  player: "Tony Test",
  position: "FB",
  team: "NIB",
  total_yards: 23,
  touchdowns: 5,
  twenty_plus_yards: 5,
  yards_attempt_average: 22,
  yards_game: 5
}
|> Repo.insert!()

%Rushing{
  attempt_game_average: 5.1,
  attempts: 12,
  first_down: 5,
  first_down_percent: 33.33333333334,
  forty_plus_yards: 12,
  fumbles: 4,
  longest: "70T",
  player: "Jeff",
  position: "QB",
  team: "QPR",
  total_yards: 55,
  touchdowns: 7,
  twenty_plus_yards: 1,
  yards_attempt_average: 5,
  yards_game: 7
}
|> Repo.insert!()
