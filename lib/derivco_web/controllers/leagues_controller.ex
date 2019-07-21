defmodule DerivcoWeb.LeaguesController do
  @moduledoc false

  use DerivcoWeb, :controller

  alias Derivco.Leagues.LeaguesGenerator

  def show_leagues(conn, _params) do
    leagues = LeaguesGenerator.get_leagues()
    render(conn, "leagues.json", leagues: leagues)
  end

  def show_leagues_by_div_season(conn, %{"div" => div, "season" => season}) do
    div
    |> LeaguesGenerator.get_leagues_by_div_season(season)
    |> do_show_leagues_by_div_season(conn)
  end

  defp do_show_leagues_by_div_season([], conn) do
    render(conn, "leagues_by_div_season_not_found.json", fixtures: [])
  end

  defp do_show_leagues_by_div_season(fixtures, conn) do
    render(conn, "leagues_by_season.json", fixtures: fixtures)
  end
end
