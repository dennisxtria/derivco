defmodule Derivco.Application do
  @moduledoc false

  use Application

  import Derivco.Metrics.Config, only: [port: 0]

  alias Derivco.{Metrics, Metrics.PrometheusExporter}

  def start(_type, _args) do
    Metrics.setup()

    [
      {Plug.Cowboy, scheme: :http, plug: PrometheusExporter, options: [port: port()]},
      Derivco.Repo,
      DerivcoWeb.Endpoint
    ]
    |> Supervisor.start_link(strategy: :one_for_one, name: Derivco.Supervisor)
  end

  def config_change(changed, _new, removed) do
    DerivcoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
