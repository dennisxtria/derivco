defmodule Derivco.Fixtures.Generator do
  @moduledoc """
  This module creates functions in compile time which return the appropriate results
  depending on the `div, season` combination.
  """

  use PrometheusDecorator

  alias NimbleCSV.RFC4180, as: CSV

  require Logger

  @external_resource "lib/derivco/fixtures/csv/data.csv"

  @typep div_season_result :: [] | [%{String.t() => String.t()}]

  {:ok, result} = File.read(@external_resource)

  parsed_fixtures = CSV.parse_string(result)

  div_season_pairs =
    parsed_fixtures
    |> Enum.reduce(MapSet.new(), fn [_id, div, season | _], acc ->
      MapSet.put(acc, {div, season})
    end)
    |> Enum.map(fn {div, season} -> %{"div" => div, "season" => season} end)

  Logger.info(fn -> "Generated all available div-season pairs" end)

  parsed_fixtures_by_key =
    Enum.reduce(parsed_fixtures, %{}, fn row, acc ->
      [_id, div, season, date, home_team, away_team, fthg, ftag, ftr, hthg, htag, htr] = row

      current_value = %{
        "date" => date,
        "homeTeam" => home_team,
        "awayTeam" => away_team,
        "fthg" => fthg,
        "ftag" => ftag,
        "ftr" => ftr,
        "hthg" => hthg,
        "htag" => htag,
        "htr" => htr
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

  Logger.info(fn -> "Generated fixtures from all available div-season pairs" end)

  for leagues_per_season <- parsed_fixtures_by_key do
    {key, value} = leagues_per_season
    {div, season} = key

    @doc """
    Returns a list of maps with the corresponding fixtures of a `div, season` pair.
    """
    @decorate counter_inc(:derivco_div_season_fixtures_requests_total)
    @decorate histogram_observe(:derivco_div_season_fixtures_requests_seconds)
    @spec get_fixtures_by_div_season(String.t(), String.t()) :: div_season_result()
    def get_fixtures_by_div_season(unquote(div), unquote(season)),
      do: unquote(Macro.escape(value))
  end

  def get_fixtures_by_div_season(_div, _season), do: []

  @doc """
  Returns all available `div, season` pairs.
  """
  @decorate counter_inc(:derivco_all_fixtures_requests_total)
  @decorate histogram_observe(:derivco_all_fixtures_requests_seconds)
  @spec get_div_season_pairs :: [%{String.t() => String.t()}]
  def get_div_season_pairs, do: unquote(Macro.escape(div_season_pairs))
end
