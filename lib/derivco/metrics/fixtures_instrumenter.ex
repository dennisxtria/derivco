defmodule Derivco.Metrics.FixturesInstrumenter do
  @moduledoc """
  This module is responsible for declaring all the metrics of the application.
  """

  use Prometheus.Metric

  def setup do
    Counter.declare(
      name: :derivco_all_fixtures_requests_total,
      help: "Count of successful all-fixtures requests"
    )

    Counter.declare(
      name: :derivco_div_season_fixtures_requests_total,
      help: "Count of successful div-season combination fixtures requests"
    )

    Histogram.declare(
      name: :derivco_all_fixtures_requests_seconds,
      help: "Duration of all-fixtures requests"
    )

    Histogram.declare(
      name: :derivco_div_season_fixtures_requests_seconds,
      help: "Duration of div-season combination fixtures requests"
    )
  end
end
