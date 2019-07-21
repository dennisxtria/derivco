defmodule DerivcoWeb.LeaguesView do
  @moduledoc false

  use DerivcoWeb, :view

  def render("leagues.json", %{leagues: leagues}) do
    %{leagues: leagues}
  end

  def render("leagues_by_season.json", %{fixtures: fixtures}) do
    %{fixtures: fixtures}
  end

  def render("leagues_by_div_season_not_found.json", _assigns) do
    %{http_status: 404, error_message: "div and season combination was not found"}
  end
end
