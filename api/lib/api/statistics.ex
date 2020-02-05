defmodule Api.Statistics do
  @moduledoc """
  The Statistics context.
  """

  import Ecto.Query, warn: false

  alias Api.Statistics.Rushing
  alias Api.Statistics.Input.File

  @doc """
  Returns the list of filtered rushing.

  ## Examples

      iex> list_rushing()
      [%Rushing{}, ...]

  """
  def list_rushing(args \\ %{}) do
    {:ok, results} = File.read()

    results
    |> Rushing.sort(args)
    |> Rushing.filter(args)

    # |> do_csv
  end

  # Figure out how to append to end of graphql response, like count/pagination summary.
  # Possibly adding second resolver? Shouldn't requery the db according to the spec.
  defp do_csv(results) do
    [results]
    |> List.insert_at(0, [
      "Player's name",
      "Player's team abreviation",
      "Player's postion",
      "Rushing Attempts Per Game Average",
      "Rushing Attempts",
      "Total Rushing Yards",
      "Rushing Average Yards Per Attempt",
      "Rushing Yards Per Game",
      "Total Rushing Touchdowns",
      "Longest Rush",
      "Rushing First Downs",
      "Rushing First Down Percentage",
      "Rushing 20+ Yards Each",
      "Rushing 40+ Yards Each",
      "Rushing Fumbles"
    ])
    |> CSV.encode()
    |> Enum.to_list()
    |> IO.inspect()
    |> to_string
  end

  # TODO
  # Add pagination + page count
  # Figure out export CSV with graphql
end
