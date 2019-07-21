use Mix.Config

app = Mix.Project.config()[:app]

config app, ecto_repos: [Derivco.Repo]

config app, DerivcoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yAPyeN6qrSOw+awUp4PkXnpT6rJGLIsrnuiqVG5BhU1OmWIbOhHNWevPIRmrzBon",
  render_errors: [view: DerivcoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Derivco.PubSub, adapter: Phoenix.PubSub.PG2]

config app, :metrics, port: 8081

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
