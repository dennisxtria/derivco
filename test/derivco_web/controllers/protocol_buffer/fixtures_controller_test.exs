defmodule DerivcoWeb.ProtocolBuffer.FixturesControllerTest do
  @moduledoc false

  use DerivcoWeb.ConnCase

  @test_fixtures "test/derivco_web/controllers/protocol_buffer/sp1_201617.txt"

  test "index/2 responds with all available div-season pairs", %{conn: conn} do
    expected = [
      %{"div" => "D1", "season" => "201617"},
      %{"div" => "E0", "season" => "201617"},
      %{"div" => "SP1", "season" => "201516"},
      %{"div" => "SP1", "season" => "201617"},
      %{"div" => "SP2", "season" => "201516"},
      %{"div" => "SP2", "season" => "201617"}
    ]

    %{assigns: %{div_season_pairs: actual}} = get(conn, "/api/div-season-pairs")

    assert actual == expected
  end

  test "show/2 responds with all available fixtures of a div-season pair", %{conn: conn} do
    expected =
      @test_fixtures
      |> File.read!()
      |> Jason.decode!()

    %{assigns: %{fixtures: actual}} = get(conn, "/api/div-season-pairs/SP1/201617/fixtures")

    assert actual == expected
  end

  test "show/2 responds with appropriate message in case of an invalid div-season pair", %{
    conn: conn
  } do
    expected = 404

    %{status: actual} = get(conn, "/api/div-season-pairs/SP1/1617/fixtures")

    assert actual == expected
  end
end
