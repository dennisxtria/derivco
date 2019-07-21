defmodule Derivco.Metrics.LeaguesInstrumenter do
  @moduledoc false

  use Prometheus.Metric

  def setup do
    Counter.declare(
      name: :derivco_leagues_requests_total,
      help: "Count of successful leagues requests"
    )

    Histogram.declare(
      name: :derivco_leagues_requests_seconds,
      help: "Duration of total leagues requests"
    )
  end
end
