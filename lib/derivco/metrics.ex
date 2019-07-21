defmodule Derivco.Metrics do
  @moduledoc """
  Common area to set up metrics.
  """

  alias Derivco.Metrics.{LeaguesInstrumenter, PrometheusExporter}

  def setup do
    LeaguesInstrumenter.setup()
    PrometheusExporter.setup()
  end
end
