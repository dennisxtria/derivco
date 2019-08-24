defmodule DerivcoWeb.Schemas do
  @moduledoc """
  This module defines the appropriate schemata that are used in the `DerivcoWeb.OpenAPIController`.
  """

  require OpenApiSpex

  alias OpenApiSpex.Schema

  defmodule DivSeasonPair do
    @moduledoc """
    This module is responsible for declaring a single `div, season` pair.
    """

    OpenApiSpex.schema(%{
      title: "Div-Season Pair",
      description: "A Div-Season pair for which fixtures are available",
      type: :object,
      properties: %{
        div: %Schema{type: :string, description: "The division identification, e.g SP1"},
        season: %Schema{type: :string, description: "The season identification, e.g 201617"}
      },
      required: [:div, :season],
      example: %{"div" => "SP1", "season" => "201617"}
    })
  end

  defmodule DivSeasonPairsResponse do
    @moduledoc """
    This module is responsible for declaring a list of `div, season` pairs.
    """

    OpenApiSpex.schema(%{
      title: "Div-Season Pairs",
      description:
        "All available combinations of Div-Season pairs for which fixtures are available",
      type: :object,
      properties: %{
        data: %Schema{
          description: "All Div-Season pairs",
          type: :array,
          items: DivSeasonPair
        }
      },
      example: %{
        "divSeasonPairs" => [
          %{"div" => "SP1", "season" => "201617"},
          %{"div" => "SP1", "season" => "201516"},
          %{"div" => "SP2", "season" => "201617"}
        ]
      }
    })
  end

  defmodule Fixture do
    @moduledoc """
    This module is responsible for declaring a single fixture of a
    corresponding `div, season` pair.
    """

    OpenApiSpex.schema(%{
      title: "A single Fixture",
      description: "A fixture of a specific Div-Season pair",
      type: :object,
      properties: %{
        date: %Schema{type: :string, description: "The date of the fixture"},
        home_team: %Schema{type: :string, description: "The name of the Home Team"},
        away_team: %Schema{type: :string, description: "The name of the Away Team"},
        fthg: %Schema{type: :string, description: "Full-Time Home Team Goals Scored"},
        ftag: %Schema{type: :string, description: "Full-Time Away Team Goals Scored"},
        ftr: %Schema{
          type: :string,
          description:
            "Full-Time Result, e.g. H stands for Home Team, A stands for Away Team, D stands for Draw"
        },
        hthg: %Schema{type: :string, description: "Half-Time Home Team Goals Scored"},
        htag: %Schema{type: :string, description: "Half-Time Away Team Goals Scored"},
        htr: %Schema{
          type: :string,
          description:
            "Half-Time Result, e.g. H stands for Home Team, A stands for Away Team, D stands for Draw"
        }
      },
      example: %{
        "date" => "20/08/2016",
        "homeTeam" => "Barcelona",
        "awayTeam" => "Betis",
        "fthg" => "6",
        "ftag" => "2",
        "ftr" => "H",
        "hthg" => "3",
        "htag" => "1",
        "htr" => "H"
      }
    })
  end

  defmodule FixturesResponse do
    @moduledoc """
    This module is responsible for declaring a list of fixtures
    that are corresponding to a`div, season` pair.
    """

    OpenApiSpex.schema(%{
      title: "Multiple fixtures",
      description: "A list of fixtures of a specific Div-Season pair",
      type: :object,
      properties: %{
        data: %Schema{
          description: "A list of fixtures of a specific Div-Season pair",
          type: :array,
          items: Fixture
        }
      },
      example: %{
        "fixtures" => [
          %{
            "date" => "20/08/2016",
            "homeTeam" => "Barcelona",
            "awayTeam" => "Betis",
            "fthg" => "6",
            "ftag" => "2",
            "ftr" => "H",
            "hthg" => "3",
            "htag" => "1",
            "htr" => "H"
          },
          %{
            "date" => "20/08/2016",
            "homeTeam" => "Granada",
            "awayTeam" => "Villarreal",
            "fthg" => "1",
            "ftag" => "1",
            "ftr" => "D",
            "hthg" => "0",
            "htag" => "0",
            "htr" => "D"
          },
          %{
            "date" => "20/08/2016",
            "homeTeam" => "Sevilla",
            "awayTeam" => "Espanol",
            "fthg" => "6",
            "ftag" => "4",
            "ftr" => "H",
            "hthg" => "3",
            "htag" => "3",
            "htr" => "D"
          }
        ]
      }
    })
  end
end
