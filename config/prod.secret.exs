use Mix.Config

app = Mix.Project.config()[:app]

config app, DerivcoWeb.Endpoint,
  http: [:inet6, port: System.get_env("PORT")],
  secret_key_base: System.get_env("SECRET_KEY_BASE")
