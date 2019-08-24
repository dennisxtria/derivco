# Template secrets configuration.
#
# Clone this file & rename it to {dev | prod | staging}.secrets.exs.
# Then edit it to configure the application credentials for your enviroment.

use Mix.Config

app = Mix.Project.config()[:app]

config app, DerivcoWeb.Endpoint,
  http: [:inet6, port: "YOUR_PORT"],
  secret_key_base: "YOUR_SECRET_KEY_BASE"
