use Mix.Config

config :derivco, Derivco.Repo,
  username: "postgres",
  password: "postgres",
  database: "derivco_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :derivco, DerivcoWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
