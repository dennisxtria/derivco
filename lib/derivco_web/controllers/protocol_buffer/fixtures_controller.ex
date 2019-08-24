defmodule DerivcoWeb.ProtocolBuffer.FixturesController do
  @moduledoc false

  use DerivcoWeb, :controller

  alias Derivco.Fixtures.Generator
  alias Derivco.Fixtures.ProtocolBuffer.{Message, Message.Response}

  @spec show_fixtures_by_div_season(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show_fixtures_by_div_season(conn, %{"div" => div, "season" => season}) do
    fixtures = Generator.get_fixtures_by_div_season(div, season)

    case fixtures do
      [] -> send_resp(conn, 404, "fixtures not available")
      _ -> do_show_fixtures_by_div_season(conn, fixtures)
    end
  end

  defp do_show_fixtures_by_div_season(conn, fixtures) do
    transformed_fixtures = Enum.map(fixtures, &Message.transform/1)

    serialized_fixtures =
      [divSeasonPairs: transformed_fixtures]
      |> Response.new()
      |> Protobuf.Serializable.serialize()

    send_resp(conn, 200, serialized_fixtures)
  end
end
