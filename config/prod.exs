use Mix.Config

app = Mix.Project.config()[:app]

config app, DerivcoWeb.Endpoint,
  http: [port: System.get_env("PORT")],
  url: [host: System.get_env("HOSTNAME")],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info

# import_config "prod.secret.exs"
