defmodule Api.Statistics.Rushing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rushing" do
    field :attempt_game_average, :float
    field :attempts, :integer
    field :first_down, :integer
    field :first_down_percent, :float
    field :forty_plus_yards, :integer
    field :fumbles, :integer
    field :longest, :string
    field :player, :string
    field :position, :string
    field :team, :string
    field :total_yards, :integer
    field :touchdowns, :integer
    field :twenty_plus_yards, :integer
    field :yards_attempt_average, :integer
    field :yards_game, :integer

    timestamps()
  end

  @doc false
  def changeset(rushing, attrs) do
    rushing
    |> cast(attrs, [
      :player,
      :team,
      :position,
      :attempt_game_average,
      :attempts,
      :total_yards,
      :yards_attempt_average,
      :yards_game,
      :touchdowns,
      :longest,
      :first_down,
      :first_down_percent,
      :twenty_plus_yards,
      :forty_plus_yards,
      :fumbles
    ])
    |> validate_required([
      :player,
      :team,
      :position,
      :attempt_game_average,
      :attempts,
      :total_yards,
      :yards_attempt_average,
      :yards_game,
      :touchdowns,
      :longest,
      :first_down,
      :first_down_percent,
      :twenty_plus_yards,
      :forty_plus_yards,
      :fumbles
    ])
  end

  def sort(rushings, %{sort: sort_args}) do
    rushings
    |> sort_by_total_yards(sort_args)
    |> sort_by_longest_rush(sort_args)
    |> sort_by_touchdowns(sort_args)
  end

  def sort(rushings, _), do: rushings

  defp sort_by_total_yards(list, %{total_yards: direction}) when byte_size(direction) > 0 do
    Enum.sort_by(list, & &1.total_yards, fn l, r ->
      {l_total, _} = l |> parse_total_yards
      {r_total, _} = r |> parse_total_yards

      case String.downcase(direction) do
        "asc" -> l_total <= r_total
        "desc" -> l_total >= r_total
      end
    end)
  end

  defp sort_by_total_yards(list, _), do: list

  defp sort_by_longest_rush(list, %{longest: direction}) when byte_size(direction) > 0 do
    Enum.sort_by(list, & &1.longest, fn l, r ->
      # add a case to catch errors and assign a zero if so?
      {l_longest, _} = parse_longest(l)
      {r_longest, _} = parse_longest(r)
      # Ignoring touchdowns; assuming it's purely based on length.
      case String.downcase(direction) do
        "asc" -> l_longest <= r_longest
        "desc" -> l_longest >= r_longest
      end
    end)
  end

  defp sort_by_longest_rush(list, _), do: list

  defp sort_by_touchdowns(list, %{touchdowns: direction}) when byte_size(direction) > 0 do
    case String.downcase(direction) do
      "asc" -> Enum.sort_by(list, & &1.touchdowns, &<=/2)
      "desc" -> Enum.sort_by(list, & &1.touchdowns, &>=/2)
    end
  end

  defp sort_by_touchdowns(list, _), do: list

  def filter(rushings, %{filter: filter_args}) do
    rushings
    |> filter_player(filter_args)
  end

  def filter(rushings, _), do: rushings

  defp filter_player(list, %{player: val}) when byte_size(val) > 0 do
    list |> Enum.filter(&(&1.player =~ ~r/#{val}/i))
  end

  defp filter_player(list, _), do: list

  defp parse_longest(longest) when is_integer(longest) or is_float(longest), do: {longest, ""}

  defp parse_longest(longest) when is_binary(longest) do
    Float.parse(longest)
  end

  defp parse_total_yards(total_yards) when is_integer(total_yards) or is_float(total_yards),
    do: {total_yards, ""}

  defp parse_total_yards(total_yards) when is_binary(total_yards) do
    total_yards |> String.replace(",", "") |> Float.parse()
  end
end

defimpl String.Chars, for: Api.Statistics.Rushing do
  def to_string(rushing) do
    "
    #{rushing.player},
    #{rushing.team},
    #{rushing.position},
    #{rushing.attempt_game_average},
    #{rushing.attempts},
    #{rushing.total_yards},
    #{rushing.yards_attempt_average},
    #{rushing.yards_game},
    #{rushing.touchdowns},
    #{rushing.longest},
    #{rushing.first_down},
    #{rushing.first_down_percent},
    #{rushing.twenty_plus_yards},
    #{rushing.forty_plus_yards},
    #{rushing.fumbles}"
  end
end
