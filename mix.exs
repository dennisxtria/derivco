defmodule Derivco.MixProject do
  use Mix.Project

  def project do
    [
      app: :derivco,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Derivco.Application, []},
      extra_applications: [:logger, :runtime_tools, :prometheus_ecto, :prometheus_ex]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ecto_sql, "~> 3.1"},
      {:ex_doc, "~> 0.20.2", only: :dev, runtime: false},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:nimble_csv, "~> 0.6.0"},
      {:phoenix, "~> 1.4.9"},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_pubsub, "~> 1.1"},
      {:postgrex, ">= 0.0.0"},

      # analysis
      {:credo, "~> 1.1", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.6", only: :dev, runtime: false},

      # metrics
      {:plug_cowboy, "~> 2.0"},
      {:prometheus_decorator, github: "dennisxtria/prometheus_decorator"},
      {:prometheus_ecto, "~> 1.4"},
      {:prometheus_ex, "~> 3.0"},
      {:prometheus_plugs, "~> 1.1"}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
