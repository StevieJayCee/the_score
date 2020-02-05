defmodule ApiWeb.Router do
  use ApiWeb, :router

  scope "/" do
    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: ApiWeb.Schema,
      interface: :simple,
      context: %{pubsub: ApiWeb.Endpoint}

    forward "/", Absinthe.Plug, schema: ApiWeb.Schema
  end
end
