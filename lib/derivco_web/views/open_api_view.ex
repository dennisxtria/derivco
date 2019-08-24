defmodule DerivcoWeb.OpenAPIView do
  @moduledoc false

  use DerivcoWeb, :view

  def render("index.json", %{div_season_pairs: div_season_pairs}) do
    %{"divSeasonPairs" => div_season_pairs}
  end

  def render("show.json", %{fixtures: fixtures}), do: %{fixtures: fixtures}
end

# 1. count the number of items in result (show leagues & show leagues by div season)
# 2. parse show leagues result and check that all leagues are present
# 3. check that a specific match is in a specific div/season combo
# 4. check from a different one and fail to find it
# 5. add defguard and reject in case of wrong format
# 6. check that first char of div is character (binary pattern match)
# 7. read csv from config, to check function generation
