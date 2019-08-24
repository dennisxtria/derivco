defmodule DerivcoWeb.OpenAPIController do
  @moduledoc false

  use DerivcoWeb, :controller

  import OpenApiSpex.Operation, only: [parameter: 5, response: 3]

  alias Derivco.Fixtures.Generator
  alias DerivcoWeb.Schemas.{DivSeasonPairsResponse, FixturesResponse}
  alias OpenApiSpex.Operation

  plug OpenApiSpex.Plug.Cast
  plug OpenApiSpex.Plug.Validate

  def open_api_operation(action) do
    apply(__MODULE__, :"#{action}_operation", [])
  end

  @spec index_operation :: OpenApiSpex.Operation.t()
  def index_operation do
    %Operation{
      tags: ["div_season_pairs"],
      summary: "Div-Season Pairs",
      description: "List of all available Div-Season pairs",
      operationId: "OpenAPIController.index",
      responses: %{
        200 => response("Div-Season Pairs List", "application/json", DivSeasonPairsResponse)
      }
    }
  end

  @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
  def index(conn, _params) do
    div_season_pairs = Generator.get_div_season_pairs()
    render(conn, "index.json", div_season_pairs: div_season_pairs)
  end

  @spec show_operation :: OpenApiSpex.Operation.t()
  def show_operation do
    %Operation{
      tags: ["fixtures"],
      summary: "Show fixtures",
      description: "Show a fixture of a specific div-season pair",
      operationId: "OpenAPIController.show",
      parameters: [
        parameter(:div, :path, :string, "Div", example: "SP1", required: true),
        parameter(:season, :path, :integer, "Season", example: 201_617, required: true)
      ],
      responses: %{
        200 => response("Fixtures", "application/json", FixturesResponse)
      }
    }
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, _params) do
    div = Map.get(conn.path_params, "div")
    season = Map.get(conn.path_params, "season")

    fixtures = Generator.get_fixtures_by_div_season(div, season)

    case fixtures do
      [] -> resp(conn, 404, Jason.encode!(%{message: "fixtures not available"}))
      _ -> render(conn, "show.json", fixtures: fixtures)
    end
  end
end
