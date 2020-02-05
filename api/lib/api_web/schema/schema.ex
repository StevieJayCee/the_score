defmodule ApiWeb.Schema do
  use Absinthe.Schema

  alias ApiWeb.RushingResolver

  @desc "One rushing statistic set"
  object :rushing do
    @desc "Player's name"
    field :player, non_null(:string)
    @desc "Player's team abreviation"
    field :team, non_null(:string)
    @desc "Player's postion"
    field :position, non_null(:string)
    @desc "Rushing Attempts Per Game Average"
    field :attempt_game_average, non_null(:integer)
    @desc "Rushing Attempts"
    field :attempts, non_null(:integer)
    @desc "Total Rushing Yards"
    # change back to string?
    field :total_yards, non_null(:integer)
    @desc "Rushing Average Yards Per Attempt"
    field :yards_attempt_average, non_null(:integer)
    @desc "Rushing Yards Per Game"
    field :yards_game, non_null(:integer)
    @desc "Total Rushing Touchdowns"
    field :touchdowns, non_null(:integer)
    @desc "Longest Rush -- a T represents a touchdown occurred"
    field :longest, non_null(:string)
    @desc "Rushing First Downs"
    field :first_down, non_null(:integer)
    @desc "Rushing First Down Percentage"
    field :first_down_percent, non_null(:float)
    @desc "Rushing 20+ Yards Each"
    field :twenty_plus_yards, non_null(:integer)
    @desc "Rushing 40+ Yards Each"
    field :forty_plus_yards, non_null(:integer)
    @desc "Rushing Fumbles"
    field :fumbles, non_null(:integer)
  end

  input_object :filter do
    @desc "Case insensitive filtering of player names"
    field :player, :string
  end

  input_object :sort do
    @desc "accepted arguments are \"asc\" and \"desc\""
    field :total_yards, :string
    @desc "accepted arguments are \"asc\" and \"desc\""
    field :longest, :string
    @desc "accepted arguments are \"asc\" and \"desc\""
    field :touchdowns, :string
  end

  @desc "What even goes here?"
  query do
    @desc """
    Returns rushing statistics for all players.\n

    Supported arguments: sort, filter.

    sort supported fields: totalYards, longest, touchdowns.

    filter supported fields: player.

    """
    field :rushing, non_null(list_of(non_null(:rushing))) do
      @desc "{player: \"And\"}"
      arg(:filter, :filter)
      @desc "{touchdowns: \"desc\"}"
      arg(:sort, :sort)
      resolve(&RushingResolver.rushing/3)
    end
  end
end
