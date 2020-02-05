defmodule Api.StatisticsTest do
  use Api.DataCase

  alias Api.Statistics

  describe "rushing" do
    test "list_rushing/0 returns all rushing" do
      # create a setup with file read and initial data count
      assert Statistics.list_rushing() |> length === 326
    end

    test "list_rushing/1 with filter returns filtered rushing" do
      results = Statistics.list_rushing(%{filter: %{player: "andre"}})

      assert length(results) === 6
      results |> Enum.each(&(&1.player =~ "andre"))
    end

    test "list_rushing/1 with empty filter returns all rushing" do
      assert Statistics.list_rushing(%{filter: %{}}) |> length === 326
      assert Statistics.list_rushing(%{filter: %{player: ""}}) |> length === 326
    end

    test "list_rushing/1 with sort by longest returns sorted rushing" do
      desc_results = Statistics.list_rushing(%{sort: %{longest: "desc"}})
      asc_results = Statistics.list_rushing(%{sort: %{longest: "asc"}})

      assert length(desc_results) === 326
      top_desc = desc_results |> hd()
      assert top_desc.longest === "85T"

      assert length(asc_results) === 326
      top_asc = asc_results |> hd()
      assert top_asc.longest === -8
    end

    test "list_rushing/1 with sort by total yards returns sorted rushing" do
      desc_results = Statistics.list_rushing(%{sort: %{total_yards: "desc"}})
      asc_results = Statistics.list_rushing(%{sort: %{total_yards: "asc"}})

      assert length(desc_results) === 326
      top_desc = desc_results |> hd()
      assert top_desc.total_yards === "1,631"

      assert length(asc_results) === 326
      top_asc = asc_results |> hd()
      assert top_asc.total_yards === -23
    end

    test "list_rushing/1 with sort by touchdowns returns sorted rushing" do
      desc_results = Statistics.list_rushing(%{sort: %{touchdowns: "desc"}})
      asc_results = Statistics.list_rushing(%{sort: %{touchdowns: "asc"}})

      assert length(desc_results) === 326
      top_desc = desc_results |> hd()
      assert top_desc.touchdowns === 18

      assert length(asc_results) === 326
      top_asc = asc_results |> hd()
      assert top_asc.touchdowns === 0
    end
  end
end
