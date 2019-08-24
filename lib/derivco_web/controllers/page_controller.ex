defmodule DerivcoWeb.PageController do
  @moduledoc false

  use DerivcoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
