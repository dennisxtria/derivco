FROM bitwalker/alpine-elixir-phoenix:latest

EXPOSE 4000
EXPOSE 8081
ENV APP_NAME=derivco \
  APP_VSN=0.1.0 \
  MIX_ENV=prod \
  HOSTNAME=localhost \
  PORT=4000 \
  PROMETHEUS_PORT=8081 \
  SECRET_KEY_BASE=yAPyeN6qrSOw+awUp4PkXnpT6rJGLIsrnuiqVG5BhU1OmWIbOhHNWevPIRmrzBon

ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

ADD . .

RUN mix do compile, phx.digest

USER default

CMD ["mix", "phx.server"]