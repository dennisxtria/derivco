defmodule DerivcoWeb.APISpec do
  @moduledoc false

  @behaviour OpenApiSpex.OpenApi

  alias DerivcoWeb.{Endpoint, Router}
  alias OpenApiSpex.{Info, OpenApi, Paths, Server}

  @impl OpenApi
  def spec do
    %OpenApi{
      info: %Info{title: "Derivco App", version: "1.0"},
      servers: [Server.from_endpoint(Endpoint)],
      paths: Paths.from_router(Router)
    }
    |> OpenApiSpex.resolve_schema_modules()
  end
end
