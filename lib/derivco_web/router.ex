defmodule DerivcoWeb.Router do
  @moduledoc false

  use DerivcoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug OpenApiSpex.Plug.PutApiSpec, module: DerivcoWeb.APISpec
  end

  pipeline :protocol_buffer_api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser
    get "/swaggerui", OpenApiSpex.Plug.SwaggerUI, path: "/api/openapi"
  end

  scope "/api" do
    pipe_through :api
    resources "/div-season-pairs", DerivcoWeb.OpenAPIController, only: [:index]
    get "/openapi", OpenApiSpex.Plug.RenderSpec, :show
    get "/div-season-pairs/:div/:season/fixtures", DerivcoWeb.OpenAPIController, :show
  end

  scope "/api", DerivcoWeb, as: :protocol_buffer_api do
    pipe_through :protocol_buffer_api

    get "/protocol-buffer/div-season-pairs/:div/:season/fixtures",
        ProtocolBuffer.FixturesController,
        :show_fixtures_by_div_season
  end
end
