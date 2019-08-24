defmodule Derivco.Metrics do
  @moduledoc """
  Common area to set up metrics.
  """

  alias Derivco.Metrics.{FixturesInstrumenter, PrometheusExporter}

  def setup do
    FixturesInstrumenter.setup()
    PrometheusExporter.setup()
  end
end
