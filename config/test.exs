use Mix.Config

app = Mix.Project.config()[:app]

config app, DerivcoWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
