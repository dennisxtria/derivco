defmodule Derivco.Leagues.LeaguesGenerator do
  @moduledoc """
  This module creates functions in compile time which return the appropriate results
  depending on the `div, season` combination.
  """

  use PrometheusDecorator

  alias NimbleCSV.RFC4180, as: CSV

  require Logger

  @external_resource "lib/derivco/leagues/csv/leagues.csv"

  @typep leagues_by_season_result ::
           []
           | [
               %{
                 div: String.t(),
                 date: String.t(),
                 home_team: String.t(),
                 away_team: String.t(),
                 fthg: String.t(),
                 ftag: String.t(),
                 ftr: String.t(),
                 hthg: String.t(),
                 htag: String.t(),
                 htr: String.t()
               }
             ]

  {:ok, result} = File.read(@external_resource)

  parsed_leagues = CSV.parse_string(result)

  parsed_leagues_by_key =
    Enum.reduce(parsed_leagues, %{}, fn row, acc ->
      [_id, div, season, date, home_team, away_team, fthg, ftag, ftr, hthg, htag, htr] = row

      current_value = %{
        div: div,
        date: date,
        home_team: home_team,
        away_team: away_team,
        fthg: fthg,
        ftag: ftag,
        ftr: ftr,
        hthg: hthg,
        htag: htag,
        htr: htr
      }

      key = {div, season}
      key_present? = Map.has_key?(acc, key)

      if key_present? do
        previous_values = Map.get(acc, key)

        Map.put(acc, key, [current_value | previous_values])
      else
        Map.put(acc, key, [current_value])
      end
    end)

  for leagues_per_season <- parsed_leagues_by_key do
    {key, value} = leagues_per_season
    {div, season} = key

    @doc """
    Returns a list of maps with the corresponding results of `div, season`.
    """
    @spec get_leagues_by_div_season(String.t(), String.t()) :: leagues_by_season_result()
    def get_leagues_by_div_season(unquote(div), unquote(season)), do: unquote(Macro.escape(value))
  end

  def get_leagues_by_div_season(_div, _season), do: []

  @doc """
  Returns all leagues.
  """
  @spec get_leagues :: [[String.t()]]
  @decorate counter_inc(:derivco_leagues_requests_total)
  def get_leagues, do: unquote(parsed_leagues)
end
