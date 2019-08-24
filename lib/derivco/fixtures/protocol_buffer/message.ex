defmodule Derivco.Fixtures.ProtocolBuffer.Message do
  @moduledoc """
  This module is responsible for declaring the `protobuf` schema and generate the
  appropriate modules and structs accordingly.
  """

  use Protobuf, """
    message DivSeasonPair {
      required string date = 1;
      required string homeTeam = 2;
      required string awayTeam = 3;
      required string fthg = 4;
      required string ftag = 5;
      required string ftr = 6;
      required string hthg = 7;
      required string htag = 8;
      required string htr = 9;
    }

    message Response {
      repeated DivSeasonPair divSeasonPairs = 1;
    }
  """

  alias Derivco.Fixtures.ProtocolBuffer.Message.DivSeasonPair

  @spec transform(%{String.t() => String.t()}) :: DivSeasonPair.t()
  def transform(fixtures) do
    %{
      "date" => date,
      "homeTeam" => home_team,
      "awayTeam" => away_team,
      "fthg" => fthg,
      "ftag" => ftag,
      "ftr" => ftr,
      "hthg" => hthg,
      "htag" => htag,
      "htr" => htr
    } = fixtures

    DivSeasonPair.new(
      date: date,
      homeTeam: home_team,
      awayTeam: away_team,
      fthg: fthg,
      ftag: ftag,
      ftr: ftr,
      hthg: hthg,
      htag: htag,
      htr: htr
    )
  end
end
