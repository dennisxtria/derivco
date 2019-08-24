defmodule Derivco.Application do
  @moduledoc false

  use Application

  alias Derivco.{Metrics, Metrics.PrometheusExporter}

  @name __MODULE__

  @doc false
  def start(_type, _args) do
    Metrics.setup()

    [
      {Plug.Cowboy, scheme: :http, plug: PrometheusExporter, options: [port: 8081]},
      DerivcoWeb.Endpoint
    ]
    |> Supervisor.start_link(strategy: :one_for_one, name: @name)
  end

  def config_change(changed, _new, removed) do
    DerivcoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
