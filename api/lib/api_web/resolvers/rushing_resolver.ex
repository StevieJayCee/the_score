defmodule ApiWeb.RushingResolver do
  alias Api.Statistics

  def rushing(_root, args, _info) do
    with rushing <- Statistics.list_rushing(args) do
      {:ok, rushing}
    end
  end
end
