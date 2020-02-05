defmodule Api.Statistics.Input.File do
  alias Api.Statistics.Rushing

  # Possible TODOS:
  # Make the file input path an env config,
  # Add HTTP client behavior and add a quantum
  # scheduler to store updates in cachex periodically.

  # Create mock HTTP client for tests / allow change to API calls

  # Move file ops to Rushing.ex. It might make more
  # sense to live there. File read can be tested separately
  # on expected data input and can declutter resolver.

  def read do
    case File.read("rushing.json") do
      {:ok, file_contents} ->
        file_contents
        |> Jason.decode!()
        |> build_rushing()

      {:error, reason} ->
        log_file_error(reason)
    end
  end

  def build_rushing(results) do
    # Data is too volatile, need to add more fine grain checks for fields,
    # expected formats and fallback logging for rows with bad/missing data.
    # Means the explicit conversions from the sort funcs could be relaxed.
    rushing =
      results
      |> Enum.map(fn json ->
        %Rushing{
          player: json["Player"],
          team: json["Team"],
          position: json["Pos"],
          attempt_game_average: json["Att/G"],
          attempts: json["Att"],
          total_yards: json["Yds"],
          yards_attempt_average: json["Avg"],
          yards_game: json["Yds/G"],
          touchdowns: json["TD"],
          longest: json["Lng"],
          first_down: json["1st"],
          first_down_percent: json["1st%"],
          twenty_plus_yards: json["20+"],
          forty_plus_yards: json["40+"],
          fumbles: json["FUM"]
        }
      end)

    {:ok, rushing}
  end

  # TODO, break this out into pattern matching + figure out what
  # is graphql version of fallback_controller.
  defp log_file_error(reason) do
    message =
      case reason do
        :enoent ->
          "rushing.json: could not be found"

        :eaccess ->
          "rushing.json: missing read permission"

        error when error in [:eisdir, :enotdir] ->
          "rushing.json: not a valid file path"

        :enomem ->
          "rushing.json: not enough memory to load file contents"
      end

    {:error, {:internal_file_read_error, message}}
  end
end
