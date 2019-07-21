defmodule Derivco.Metrics.Config do
  @moduledoc """
  Provides access to configuration values for the Backend modules.
  """

  import Application, only: [get_env: 3]

  @app Mix.Project.config()[:app]

  @doc """
  Port can be configurable from `config.exs`.
  """
  @spec port :: non_neg_integer
  def port, do: get_env(@app, :metrics, [])[:port]
end
