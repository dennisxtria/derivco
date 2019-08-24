use Mix.Config

app = Mix.Project.config()[:app]

config app, DerivcoWeb.Endpoint,
  http: [port: System.get_env("PORT")],
  url: [host: System.get_env("HOSTNAME")],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: DerivcoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Derivco.PubSub, adapter: Phoenix.PubSub.PG2]

config app, :metrics, port: System.get_env("PROMETHEUS_PORT")

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"

if File.exists?("#{__DIR__}/#{Mix.env()}.secrets.exs") do
  import_config "./#{Mix.env()}.secrets.exs"
end
