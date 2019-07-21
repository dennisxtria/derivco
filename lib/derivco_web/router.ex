defmodule DerivcoWeb.Router do
  use DerivcoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DerivcoWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", DerivcoWeb, as: :api do
    pipe_through :api

    get "/leagues", LeaguesController, :show_leagues

    get "/leagues/:div/:season", LeaguesController, :show_leagues_by_div_season
  end
end
